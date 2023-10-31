# vim:foldmethod=indent:foldlevel=0

base_branch() {
  if git rev-parse -q --verify develop > /dev/null; then
    echo "develop"
  else
    echo "master"
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
  if [[ $# == 0 ]]; then
    base_branch=$(base_branch)
    branches=$(git branch)
    targets=$(echo $branches | awk '{$1=$1};1' | $(fzf_prog) -m --preview 'git short-log $base_branch..{} | head')

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

br() {
  if [[ $# == 0 ]]; then
    # have to assign as variable because the preview command will not see the function
    base_branch=$(base_branch)
    branches=$(git branch)
    target=$(echo $branches | awk '{$1=$1};1' | $(fzf_prog) --preview 'git short-log $base_branch..{} | head')

    if [[ $target != '' ]]; then
      git checkout $(echo $target)
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
  base_branch=$(base_branch)
  branches=$(git branch)
  target_branch=$(echo $branches | awk '{$1=$1};1' | $(fzf_prog) --preview 'git short-log $base_branch..{} | head')

  git cherry-pick $(git log --pretty=oneline $(echo $target_branch) | $(fzf_prog) -m --preview "echo {} | cut -f 1 -d' ' | xargs -I SHA git show --color=always --pretty=fuller --stat SHA"| awk '{ print $1 }' )
}

changed_files() {
  if [[ $# == 0 ]]; then
    target=$(git status -s | awk '{ print $2 }' | $(fzf_prog) -m --preview 'git diff --color=always {}')
    if [[ $target != '' ]]; then
      nvim $(echo $target)
    fi
  fi
}
bindkey -s '^g' 'changed_files\n'



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
