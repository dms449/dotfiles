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

current_release_branch() {
  git branch --list 'release/*' --no-merged | awk '{ print $1 }'
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

ap() {
  git add -p $(git status -s | awk '{ print $2 }' | $(fzf_prog) -m --preview 'git diff --color=always {}')
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

git-nuke() {
  if [[ $# == 1 ]]; then
    confirm && git branch -D $1 && git push origin :$1
  else
    echo "No single branch name given"
    return 1;
  fi
}

fuzzy_branch_select() {
  branches=$(git branch)
  echo $(echo $branches | awk '{$1=$1};1' | $(fzf_prog) --preview 'git short-log $base_branch..{} | head')
}


gdm () {
  base_branch=$(base_branch)
  if [[ $base_branch == "main" ]]
  then
    git branch --merged origin/main | grep -v main | xargs git branch -d
  elif [[ $base_branch == "develop" ]]
  then
    git branch --merged origin/develop | grep -v develop | xargs git branch -d
  else
      git branch --merged origin/master | grep -v master | xargs git branch -d
  fi
}

gbD() {
  if [[ $# == 0 ]]
  then
      targets=$(fuzzy_branch_select)
      echo $targets
      confirm && git branch -D $(echo $targets)
  fi
}

dev() {
  git checkout develop && git fetch && git rebase
}

ir() {
  if [ "$(current_branch)" = "$(base_branch)" ]; then
    git rebase -i HEAD~$@
  else
    if [[ $# > 0 ]]; then
      git rebase -i $@
    else
      git rebase -i $(base_branch)
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

cfu() {
  if [ "$(current_branch)" = "$(base_branch)" ]; then
    target=$(git log --max-count=50 --pretty=oneline | $(fzf_prog) --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA" | awk '{ print $1 }')
  else
    target=$(git log --pretty=oneline $(base_branch).. | $(fzf_prog) --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA" | awk '{ print $1 }')
  fi

  if [[ $target != '' ]]; then
    git commit --fixup $(echo $target)
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
  git branch --merged origin/develop | grep -v master | grep -v develop | xargs git branch -d
}

cherry() {
  target_branch=$(fuzzy_branch_select)

  if [[ -n $target_branch ]]; then
    git cherry-pick $(git log --pretty=oneline $(echo $target_branch) | $(fzf_prog) -m --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA"| awk '{ print $1 }' )
  fi
}

prb() {
  issue_id=$(current_branch | grep -o 'BW-\d*')
  gh pr create -R="BaldwinAviation/baldwin-web" -B=$(base_branch) -t="$(current_branch)" -b="https://portsideco.atlassian.net/browse/$issue_id" $@
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
