card() {
  wf --show-card --card $(git rev-parse --abbrev-ref HEAD | read branch; echo ${${branch[(ws:/:)2]}[(ws:-:)1]})
}

finished() {
  CARD=$(git rev-parse --abbrev-ref HEAD | sed 's:.*/::' | sed 's/-.*//')
  wf --finish-card --card $CARD
}

next_story() {
  wf --start-card --card $(wf --list-unstarted-cards | fzf-tmux | awk '{print $1;}') --include-related
}

testing() {
  CARD=$(git rev-parse --abbrev-ref HEAD | sed 's:.*/::' | sed 's/-.*//')
  wf --create-testing-lists --card $CARD
}

buildrelease() {
  if [[ $# > 0 ]]; then
    wf --approved-prs | fzf -m | cut -d' ' -f1 | tr '\n' ',' | xargs wf --build-release --list $1 --pull-requests
  else
    echo "argument required (release name)"
  fi
}

deploy() {
  if [[ $# > 0 ]]; then
    wf --deploy --list $1
  else
    echo "argument required (release name)"
  fi
}
