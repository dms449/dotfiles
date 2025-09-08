# Setup fzf
# ---------
if [[ ! "$PATH" == *${HOME}/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/.config/fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/.config/fzf/key-bindings.zsh"
