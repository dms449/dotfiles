# Setup fzf
# ---------
if [[ ! "$PATH" == *"$HOME/.fzf/fzf/bin"* ]]; then
  export PATH="${PATH:+${PATH}:}$HOME/.fzf/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "$HOME/.fzf/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "$HOME/.fzf/key-bindings.zsh"
