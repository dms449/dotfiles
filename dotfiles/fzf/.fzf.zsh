# Setup fzf
# ---------
if [[ ! "$PATH" == ${HOME}/.fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}${HOME}/.fzf/bin"
fi

# FZF variables
export FZF_COMPLETION_TRIGGER=';;'

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "${HOME}/.config/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "${HOME}/.config/fzf/shell/key-bindings.zsh"
