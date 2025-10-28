
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
  # Parse command line arguments
  local create_worktree=false
  while [[ $# -gt 0 ]]; do
    case $1 in
      -wt)
        create_worktree=true
        shift
        ;;
      *)
        echo "Unknown option: $1"
        echo "Usage: issues [-wt]"
        echo "  -wt: Create a new worktree with the branch name and cd into it"
        return 1
        ;;
    esac
  done

  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    return 1
  fi

  # Get issues using gh and format them for fzf
  local selected_issue
  selected_issue=$(gh issue list --state open --limit 100 --json number,title,labels \
    --template '{{range .}}{{.number}}: {{.title}}{{"\n"}}{{end}}' | \
    $(fzf_prog) --preview 'gh issue view {1} --json body --template "{{.body}}"' \
    --preview-window=right:50%:wrap)

  if [[ -z "$selected_issue" ]]; then
    echo "No issue selected"
    return 0
  fi

  # Extract issue number and title, then create branch name
  local issue_number=$(echo "$selected_issue" | sed 's/:.*$//')
  local issue_title=$(echo "$selected_issue" | sed 's/^[0-9]*: //')
  local sanitized_title=$(echo "$issue_title" | tr '[:upper:]' '[:lower:]' | sed 's/[^a-z0-9]/-/g' | sed 's/--*/-/g' | sed 's/^-\|-$//g')
  local branch_name="${issue_number}-${sanitized_title}"

  if [[ "$create_worktree" == true ]]; then
    echo "Creating worktree and branch: $branch_name"

    # Ensure we're on develop and it's up to date
    git checkout develop
    git pull origin develop

    # Create worktree with new branch
    local worktree_path="../$branch_name"
    git worktree add "$worktree_path" -b "$branch_name"

    # Change to the new worktree directory
    cd "$worktree_path"
    echo "Changed to worktree directory: $(pwd)"
  else
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

move_issue() {
  local issue_id="$1"
  local status="$2"

  if [[ -z "$issue_id" || -z "$status" ]]; then
    echo "Usage: move_issue <issue_id> <status>"
    return 1
  fi

  # Check if gh CLI is available
  if ! command -v gh &> /dev/null; then
    echo "GitHub CLI (gh) is not installed. Please install it first."
    return 1
  fi

  echo "Searching for issue #${issue_id} in project..."

  # Get project items and find the one matching our issue ID
  local project_item
  project_item=$(gh project item-list --owner "Samwise-PSM" 1 --format json | \
    jq -r --arg issue_id "$issue_id" '.items[] | select(.content.number == ($issue_id | tonumber)) | .id')

  if [[ -z "$project_item" ]]; then
    echo "Issue #${issue_id} not found in project"
    return 1
  fi

  echo "Found issue #${issue_id} in project (item ID: ${project_item})"
  echo "Moving to '${status}' status..."

  # Edit the project item to move it to the specified status
  gh project item-edit --id "$project_item" --field-name "Status" --text "$status"

  if [[ $? -eq 0 ]]; then
    echo "✅ Successfully moved issue #${issue_id} to '${status}'"
  else
    echo "❌ Failed to move issue #${issue_id} to '${status}'"
    return 1
  fi
}
