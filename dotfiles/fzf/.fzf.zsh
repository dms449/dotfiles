# Setup fzf
# ---------
if [[ ! "$PATH" == */home/dms449/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/dms449/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/dms449/.config/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/dms449/.config/fzf/shell/key-bindings.zsh"
