# vim:foldmethod=indent:foldlevel=0
#
base_branch() {
    if git rev-parse -q --verify develop > /dev/null
    then
        echo "develop"
    elif git rev-parse -q --verify main > /dev/null
    then
        echo "main"
    elif git rev-parse -q --verify master > /dev/null
    then
        echo "master"
    else
        echo "Unable to determine base branch"
    fi
}

current_branch() {
  git rev-parse --abbrev-ref HEAD
}

g() {
  if [[ $# > 0 ]]; then
    git $@
  else
    git status
  fi
}

a() {
  git add $(git status -s | awk '{ print $2 }' | $(fzf_prog) -m --preview 'git diff --color=always {}')
}

cm() {
  if [[ $# > 0 ]]; then
    git commit -m $@
  else
    git commit -v
  fi
}

co() {
  if [[ $# > 0 ]]; then
    git checkout $@
  else
    git checkout $(git status -s | awk '{ print $2 }' | $(fzf_prog) -m --preview 'git diff --color=always {}')
  fi
}

fuzzy_branch_select() {
  branches=$(git branch)
  selected=$(echo $branches | awk '{$1=$1};1' | $(fzf_prog) --preview 'git short-log $base_branch..{} | head')
  # Strip '+ ' prefix if branch is in another worktree
  echo $(echo $selected | sed 's/^+ *//')
}

gbD() {
  if [[ $# == 0 ]]
  then
      branches=$(git branch)
      targets=$(echo $branches | awk '{$1=$1};1' | $(fzf_prog) -m --preview 'git short-log $base_branch..{} | head')
      # Strip '+ ' prefix if branches are in another worktree
      targets=$(echo $targets | sed 's/+ *//g')
      echo $targets
      confirm && git branch -D $(echo $targets)
  fi
}

dev() {
  git checkout develop && git fetch && git rebase
}

main() {
  git checkout main && git fetch && git rebase
}

ir() {
  if [ "$(current_branch)" = "$(base_branch)" ]; then
    git rebase -i HEAD~$@
  else
    if [[ $# > 0 ]]; then
      git rebase -i $@
    else
      # Use fzf to select branch for interactive rebase
      base_branch=$(base_branch)
      target_branch=$(fuzzy_branch_select)

      if [[ $target_branch != '' ]]; then
        git rebase -i $(echo $target_branch)
      fi
    fi
  fi
}

_ir_completion () {
    if [[ $LBUFFER == "ir "* ]]; then
        local selected_branch=$(git branch --sort=-committerdate | sed 's/..//' | fzf --height 20%)
        if [[ -n $selected_branch ]]; then
            LBUFFER="${LBUFFER% } $selected_branch"
        fi
        zle redisplay
    else
        zle complete-word
    fi
}

zle -N _ir_completion
bindkey '^I' _ir_completion


br() {
  if [[ $# == 0 ]]; then
    target=$(fuzzy_branch_select)

    if [[ -n $target ]]; then
      # Check if the branch is already checked out in another worktree
      worktree_path=$(git worktree list --porcelain | awk -v branch="$target" '
        /^worktree / { path = substr($0, 10) }
        /^branch / && substr($0, 8) == "refs/heads/" branch { print path; exit }
      ')

      if [[ -n $worktree_path ]]; then

        echo "Branch '$target' is already checked out in worktree: $worktree_path"
        cd "$worktree_path"
      else
        git checkout $(echo $target)
      fi
    fi
  fi
}

changes() {
  if [[ $# > 0 ]]; then
    tig "$@".."$(git rev-parse --abbrev-ref HEAD)"
  else
    tig $(base_branch).."$(git rev-parse --abbrev-ref HEAD)"
  fi
}

piw() {
  msg=$(git log -1 --pretty=%B)
  if [ "$msg" = "WIP" ]; then
    git reset HEAD~1
  else
    echo "no WIP available"
  fi
}

clean_branches() {
  # Get list of merged branches to delete (excluding main/develop/prod)
  local branches_to_delete=$(git branch --merged origin/main | grep -v main | grep -v develop | grep -v prod | sed 's/^[* ] //')

  if [[ -z "$branches_to_delete" ]]; then
    echo "No merged branches to clean up"
    return 0
  fi

  echo "Branches to be deleted:"
  echo "$branches_to_delete"

  # For each branch, check if there's a corresponding worktree and remove it
  echo "$branches_to_delete" | while read -r branch; do
    if [[ -n "$branch" ]]; then
      # Check if there's a worktree for this branch
      local worktree_path=$(git worktree list --porcelain | awk -v branch="$branch" '
        /^worktree / { path = substr($0, 10) }
        /^branch / && substr($0, 8) == "refs/heads/" branch { print path; exit }
      ')

      if [[ -n "$worktree_path" ]]; then
        echo "Removing worktree for branch '$branch': $worktree_path"
        git worktree remove "$worktree_path" --force
      fi
    fi
  done

  # Delete the merged branches
  echo "$branches_to_delete" | xargs git branch -d
}

cherry() {
  target_branch=$(fuzzy_branch_select)

  if [[ -n $target_branch ]]; then
    git cherry-pick $(git log --pretty=oneline $(echo $target_branch) | $(fzf_prog) -m --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA"| awk '{ print $1 }' )
  fi
}

changed_files() {
  if [[ $# == 0 ]]; then
    target=$(git status -s | awk '{ print $2 }' | $(fzf_prog) -m --preview 'git diff --color=always {}')
    if [[ $target != '' ]]; then
      nvim $(echo $target)
    fi
  fi
}

delete_git_swap() {
  rm -rf ~/.local/state/nvim/swap
}

bindkey -s '^g' 'changed_files\n'

wt() {
  if [[ $# == 0 ]]; then
    # Get list of worktrees, excluding the main one (marked with bare)
    worktrees=$(git worktree list --porcelain | grep -E '^worktree ' | sed 's/^worktree //' | grep -v '(bare)$')

    if [[ -z $worktrees ]]; then
      echo "No worktrees found"
      return 1
    fi

    # Use fzf to select a worktree
    selected=$(echo $worktrees | $(fzf_prog) --preview 'ls -la {}' --prompt="Select worktree: ")

    if [[ -n $selected ]]; then
      cd "$selected"
    fi
  else
    # Pass through to git worktree with arguments
    git worktree $@
  fi
}

# Complete g like git
compdef g=git

alias branches="git --no-pager branch -l"
alias stash="git stash -u"
alias pop="git stash pop"
alias ga="git add -A"
alias wip="git add --all && git commit -m 'WIP' && git push"
alias clean='git clean -fd'
alias grc='git rebase --continue'
alias lg='lazygit'
