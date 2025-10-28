# GitHub project cache - populated by gh_project_init
# Stores JSON from: gh project field-list and gh project view
typeset -g GH_PROJECT_CACHE=""
typeset -g GH_PROJECT_NODE_ID=""

gh_project_init() {
  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed." >&2
    return 1
  fi

  if [[ -z "$GH_PROJECT_NUMBER" || -z "$GH_PROJECT_OWNER" ]]; then
    echo "GH_PROJECT_NUMBER and GH_PROJECT_OWNER must be set" >&2
    return 1
  fi

  echo "Fetching GitHub project metadata..."

  # Cache the field list (contains status field ID and status options)
  GH_PROJECT_CACHE=$(gh project field-list "$GH_PROJECT_NUMBER" --owner "$GH_PROJECT_OWNER" --format json 2>/dev/null)
  if [[ -z "$GH_PROJECT_CACHE" ]]; then
    echo "Failed to fetch project fields" >&2
    return 1
  fi

  # Cache the project node ID
  GH_PROJECT_NODE_ID=$(gh project view "$GH_PROJECT_NUMBER" --owner "$GH_PROJECT_OWNER" --format json 2>/dev/null | jq -r '.id')
  if [[ -z "$GH_PROJECT_NODE_ID" || "$GH_PROJECT_NODE_ID" == "null" ]]; then
    echo "Failed to fetch project node ID" >&2
    return 1
  fi

  echo "Project cache initialized"
  echo "Available statuses:"
  echo "$GH_PROJECT_CACHE" | jq -r '.fields[] | select(.name == "Status") | .options[].name' | sed 's/^/  - /'
}

prd() {
  local branch=$(current_branch)
  local args=("$@")
  local issue_number=""

  # Check if branch name starts with an integer (issue number)
  if [[ $branch =~ ^[0-9]+ ]]; then
    issue_number=$(echo "$branch" | grep -o '^[0-9]\+')
    local body_text=" Issue: #${issue_number}"

    # Add the body text to the arguments
    args+=("-b" "$body_text")
  fi

  if gh pr create -R="$GH_PROJECT_OWNER/monorepo" -B=main -t="$branch" "${args[@]}"; then
    # Move issue to Code Review if we have an issue number
    if [[ -n "$issue_number" ]]; then
      move_issue "$issue_number" "Code Review"
    fi
  fi
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

  # Check if I'm assigned to the issue, if not assign me
  local my_username=$(gh api user --jq '.login')
  local is_assigned=$(gh issue view "$issue_number" --json assignees --jq ".assignees[].login | select(. == \"$my_username\")")
  if [[ -z "$is_assigned" ]]; then
    echo "Assigning myself to issue #$issue_number..."
    gh issue edit "$issue_number" --add-assignee @me
  fi

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

  # Move issue to In Progress
  move_issue "$issue_number" "In Progress"
}

close_issues() {
  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed."
    return 1
  fi

  # Auto-initialize cache if empty
  if [[ -z "$GH_PROJECT_CACHE" || -z "$GH_PROJECT_NODE_ID" ]]; then
    echo "Project cache not initialized, running gh_project_init..."
    gh_project_init || return 1
  fi

  # Get closed issues assigned to me
  echo "Fetching closed issues assigned to me..."
  local closed_issues
  closed_issues=$(gh issue list --assignee @me --state closed --sort updated --order desc --limit 50 --json number,title)

  local issue_count=$(echo "$closed_issues" | jq -r '.[] | .number' | wc -l | tr -d ' ')
  echo "Found $issue_count closed issues"

  # Process each closed issue
  echo "$closed_issues" | jq -r '.[] | "\(.number) \(.title)"' | while read -r issue_number issue_title; do
    # Get current status using gh's built-in --jq to avoid control character issues
    local current_status
    current_status=$(gh project item-list "$GH_PROJECT_NUMBER" --owner "$GH_PROJECT_OWNER" --limit 500 --format json \
      --jq ".items[] | select(.content.number == $issue_number) | .status" 2>/dev/null)

    # Skip if already Done
    if [[ "$current_status" == "Done" ]]; then
      echo "  #$issue_number: Already Done, skipping"
      continue
    fi

    # Skip if already Staging
    if [[ "$current_status" == "Staging" ]]; then
      echo "  #$issue_number: Already Staging, skipping"
      continue
    fi

    # Check if there's a merged PR for this issue
    local merged_pr
    merged_pr=$(gh pr list --search "$issue_number in:title" --state merged --limit 1 --json number,title 2>/dev/null | jq -r '.[0].number // empty')

    if [[ -n "$merged_pr" ]]; then
      echo "  #$issue_number: Found merged PR #$merged_pr, moving to Staging..."
      #move_issue "$issue_number" "Staging"
    else
      echo "  #$issue_number: No merged PR found (status: ${current_status:-not in project})"
    fi
  done

  echo "Done processing closed issues"
}

move_issue() {
  local issue_id="$1"
  local target_status="$2"

  if [[ -z "$issue_id" || -z "$target_status" ]]; then
    echo "Usage: move_issue <issue_number> <status>"
    echo "Example: move_issue 959 \"In Progress\""
    echo ""
    echo "Run 'gh_project_init' first to see available statuses"
    return 1
  fi

  # Auto-initialize cache if empty
  if [[ -z "$GH_PROJECT_CACHE" || -z "$GH_PROJECT_NODE_ID" ]]; then
    echo "Project cache not initialized, running gh_project_init..."
    gh_project_init || return 1
  fi

  # Get status field ID and target status option ID from cache
  local status_field_id
  local target_status_id
  status_field_id=$(echo "$GH_PROJECT_CACHE" | jq -r '.fields[] | select(.name == "Status") | .id')
  target_status_id=$(echo "$GH_PROJECT_CACHE" | jq -r --arg status "$target_status" '.fields[] | select(.name == "Status") | .options[] | select(.name == $status) | .id')

  if [[ -z "$target_status_id" || "$target_status_id" == "null" ]]; then
    echo "Invalid status: '$target_status'"
    echo "Available statuses:"
    echo "$GH_PROJECT_CACHE" | jq -r '.fields[] | select(.name == "Status") | .options[].name' | sed 's/^/  - /'
    return 1
  fi

  # Get project item ID using gh's built-in --jq to avoid control character issues
  local project_item
  project_item=$(gh project item-list "$GH_PROJECT_NUMBER" --owner "$GH_PROJECT_OWNER" --limit 500 --format json \
    --jq ".items[] | select(.content.number == $issue_id) | .id" 2>/dev/null)

  if [[ -z "$project_item" || "$project_item" == "null" ]]; then
    echo "Issue #${issue_id} not found in project"
    return 1
  fi

  echo "Moving issue #${issue_id} to '${target_status}'..."

  # Edit the project item
  if gh project item-edit --id "$project_item" --project-id "$GH_PROJECT_NODE_ID" --field-id "$status_field_id" --single-select-option-id "$target_status_id"; then
    echo "Successfully moved issue #${issue_id} to '${target_status}'"
  else
    echo "Failed to move issue #${issue_id}"
    return 1
  fi
}
