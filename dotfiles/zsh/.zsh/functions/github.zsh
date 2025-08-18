
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

  gh pr create -R="Samwise-PSM/monorepo" -B=develop -t="$branch" "${args[@]}"
}

issues() {
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
    git checkout develop
    git pull origin develop
    # Create new branch
    git checkout -b "$branch_name"
  fi
}
