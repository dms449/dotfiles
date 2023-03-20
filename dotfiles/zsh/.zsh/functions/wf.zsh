function card() {
  wf --show-card --card $(git rev-parse --abbrev-ref HEAD | read branch; echo ${${branch[(ws:/:)2]}[(ws:-:)1]})
}

function finished() {
  CARD=$(git rev-parse --abbrev-ref HEAD | sed 's:.*/::' | sed 's/-.*//')
  wf --finish-card --card $CARD
}

function next_story() {
  wf --start-card --card $(wf --list-unstarted-cards | fzf-tmux | awk '{print $1;}')
}

function testing() {
  CARD=$(git rev-parse --abbrev-ref HEAD | sed 's:.*/::' | sed 's/-.*//')
  wf --create-testing-lists --card $CARD
}

