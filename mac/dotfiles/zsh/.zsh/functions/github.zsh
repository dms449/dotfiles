
# GitHub project status mapping from environment variable
# Expected format: "Todo:f75ad846,In Progress:47fc9ee4,Code Review:3a5b23dc,Staging:f26b38c1,Done:98236657"
typeset -A github_status_map

if [[ -n "$GH_PROJECT_STATUS_MAP" ]]; then
  # Parse the environment variable into the associative array
  local IFS=','
  local -a status_pairs=("${(s:,:)GH_PROJECT_STATUS_MAP}")
  for pair in "${status_pairs[@]}"; do
    local key="${pair%%:*}"
    local value="${pair##*:}"
    github_status_map[$key]="$value"
  done
else
  # Fallback to hardcoded values if environment variable not set
  github_status_map=(
    "Todo" "f75ad846"
    "In Progress" "47fc9ee4"
    "Code Review" "3a5b23dc"
    "Staging" "f26b38c1"
    "Done" "98236657"
  )
fi

prd() {
  local branch=$(current_branch)
  local args=("$@")

  # Check if branch name starts with an integer (issue number)
  if [[ $branch =~ ^[0-9]+ ]]; then
    local issue_number=$(echo "$branch" | grep -o '^[0-9]\+')
    local body_text=" Issue: #${issue_number}"

    # Add the body text to the arguments
    args+=("-b" "$body_text")
  fi

  gh pr create -R="$GH_PROJECT_OWNER/monorepo" -B=main -t="$branch" "${args[@]}"
}

issues() {
  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    return 1
  fi

  # Check if we're in a git repository
  local current_worktree=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -z "$current_worktree" ]]; then
    echo "Not in a git repository"
    return 1
  fi

  # Get issues using gh and format them for fzf
  local selected_issue
  selected_issue=$(gh issue list --state open --limit 100 --json number,title,labels \
    --template '{{range .}}{{.number}}: {{.title}}{{"\n"}}{{end}}' | \
    $(fzf_prog) --preview 'gh issue view {1} --json body --template "{{.body}}"' \
    --preview-window=right:50%:wrap --header="Select an issue:")

  if [[ -z "$selected_issue" ]]; then
    echo "No issue selected"
    return 0
  fi

  # Extract issue number and title, then create branch name
  local issue_number=$(echo "$selected_issue" | sed 's/:.*$//')
  local issue_title=$(echo "$selected_issue" | sed 's/^[0-9]*: //')
  local sanitized_title=$(echo "$issue_title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
  local branch_name="${issue_number}-${sanitized_title}"

  # Get list of worktrees with current one first
  local worktree_list=""

  # Get all worktrees and put current one first
  local all_worktrees=$(git worktree list --porcelain | grep '^worktree ' | sed 's/^worktree //')
  local other_worktrees=$(echo "$all_worktrees" | grep -v "^$current_worktree$")

  worktree_list="$current_worktree (current)"
  if [[ -n "$other_worktrees" ]]; then
    worktree_list="$worktree_list"$'\n'"$other_worktrees"
  fi
  worktree_list="$worktree_list"$'\n'"+ Create new worktree"

  # Let user select worktree
  local selected_worktree_line
  selected_worktree_line=$(echo "$worktree_list" | $(fzf_prog) --header="Select worktree for issue #${issue_number}: ${issue_title}")

  if [[ -z "$selected_worktree_line" ]]; then
    echo "No worktree selected"
    return 0
  fi

  # Handle worktree selection
  if [[ "$selected_worktree_line" == *"+ Create new worktree" ]]; then
    echo "Creating worktree and branch: $branch_name"

    # Ensure we're on develop and it's up to date
    git checkout develop
    git pull origin develop

    # Create worktree with new branch
    local worktree_path="../$branch_name"
    git worktree add "$worktree_path" -b "$branch_name"

    # Copy .env file if it exists
    if [[ -f ".env" ]]; then
      cp ".env" "$worktree_path/"
      echo "Copied .env file to worktree directory"
    fi

    # Change to the new worktree directory
    cd "$worktree_path"
    echo "Changed to worktree directory: $(pwd)"
  else
    # Extract worktree path (remove " (current)" if present)
    local selected_worktree=$(echo "$selected_worktree_line" | sed 's/ (current)$//')

    # Change to selected worktree
    cd "$selected_worktree"
    echo "Changed to worktree: $selected_worktree"

    echo "Creating/checking out branch: $branch_name"

    # Check if branch already exists locally
    if git show-ref --verify --quiet refs/heads/"$branch_name"; then
      echo "Branch '$branch_name' already exists locally. Checking it out..."
      git checkout "$branch_name"
    # Check if branch exists on remote
    elif git show-ref --verify --quiet refs/remotes/origin/"$branch_name"; then
      echo "Branch '$branch_name' exists on remote. Checking it out..."
      git checkout -b "$branch_name" "origin/$branch_name"
    else
      echo "Creating new branch '$branch_name' off of develop..."
      # Ensure we're on develop and it's up to date
      git checkout main
      git pull origin main
      # Create new branch
      git checkout -b "$branch_name"
    fi
  fi
}

get_github_project_item_id() {
  local issue_number="$1"

  if [[ -z "$issue_number" ]]; then
    echo "Usage: get_github_project_item_id <issue_number>"
    return 1
  fi

  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first." >&2
    return 1
  fi

  # Get project items and find the one matching our issue ID
  local project_item_id
  project_item_id=$(gh project item-list $GH_PROJECT_NUMBER --owner "$GH_PROJECT_OWNER" --limit 500 --format json 2>/dev/null | \
    jq -r --arg issue_id "$issue_number" '.items[] | select(.content.number == ($issue_id | tonumber)) | .id' 2>/dev/null)

  if [[ -z "$project_item_id" || "$project_item_id" == "null" ]]; then
    echo "Issue #${issue_number} not found in project" >&2
    return 1
  fi

  echo "$project_item_id"
  return 0
}

get_status_field_id() {
  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first." >&2
    return 1
  fi

  # Get the Status field ID from the project
  local status_field_id
  status_field_id=$(gh project field-list $GH_PROJECT_NUMBER --owner "$GH_PROJECT_OWNER" --format json 2>/dev/null | \
    jq -r '.fields[] | select(.name == "Status") | .id' 2>/dev/null)

  if [[ -z "$status_field_id" || "$status_field_id" == "null" ]]; then
    echo "Status field not found in project" >&2
    return 1
  fi

  echo "$status_field_id"
  return 0
}

get_in_progress_status_id() {
  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first." >&2
    return 1
  fi

  local in_progress_status_id
  in_progress_status_id=$(gh project field-list $GH_PROJECT_NUMBER --owner $GH_PROJECT_OWNER --format json | jq '.fields[] | select(.name == "Status") | .options')

  if [[ -z "$in_progress_status_id" || "$in_progress_status_id" == "null" ]]; then
    echo "In progress status not found in project" >&2
    return 1
  fi

  echo "$in_progress_status_id"
  return 0
}

move_issue() {
  local issue_id="$1"
  local target_status="$2"

  if [[ -z "$issue_id" || -z "$target_status" ]]; then
    echo "Usage: move_issue <issue_id> <status>"
    return 1
  fi

  echo "Searching for issue #${issue_id} in project..."

  # Get project item ID using the reusable function
  local project_item
  project_item=$(get_github_project_item_id "$issue_id")

  if [[ $? -ne 0 ]]; then
    return 1
  fi

  echo "Found issue #${issue_id} in project (item ID: ${project_item})"

  # Use the Status field ID from environment variable
  local status_field_id="$GH_PROJECT_STATUS_FIELD_ID"

  # Look up status ID from the mapping
  local target_status_id="${github_status_map[$target_status]}"

  if [[ -z "$target_status_id" ]]; then
    echo "❌ Invalid status: '$target_status'. Valid options: ${(k)github_status_map[@]}"
    return 1
  fi

  echo "Moving to '${target_status}' status (ID: ${target_status_id})..."

  # Edit the project item to move it to the specified status using field ID
  gh project item-edit --id "$project_item" --project-id $GH_PROJECT_NUMBER --field-id "$status_field_id" --single-select-option-id "$target_status_id"
  if [[ $? -eq 0 ]]; then
    echo "✅ Successfully moved issue #${issue_id} to '${target_status}'"
  else
    echo "❌ Failed to move issue #${issue_id} to '${target_status}'"
    return 1
  fi
}
