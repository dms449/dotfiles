# Setup fzf
# ---------
if [[ ! "$PATH" == */home/dms/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/dms/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/dms/.fzf/shell/completion.bash" 2> /dev/null

# Key bindings
# ------------
source "/home/dms/.fzf/shell/key-bindings.bash"
