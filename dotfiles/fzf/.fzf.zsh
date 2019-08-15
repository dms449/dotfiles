# Setup fzf
# ---------
if [[ ! "$PATH" == */home/dms/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/dms/.fzf/bin"
fi

# FZF variables
export FZF_COMPLETION_TRIGGER=';;'

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/dms/.fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/dms/.fzf/shell/key-bindings.zsh"
