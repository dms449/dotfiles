# use zPrezto if it exists
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# set the number of threads for julia
export JULIA_NUM_THREADS=8

export KEYTIMEOUT=1
#=========================== Theme Custimization =============================
# override some theme related zsh settings
SPACESHIP_PROMPT_ORDER=(
  user
  venv
  pyenv
  dir
  julia
  docker
  aws
  exec_time
  line_sep
  battery
  jobs
  exit_code
  vi_mode
  char
)

SPACESHIP_RPROMPT_ORDER=(
  git
  time
)

#SPACESHIP_PROMPT_PREFIXES_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true

# edit the vim
SPACESHIP_VI_MODE_INSERT=""
SPACESHIP_VI_MODE_NORMAL="N"
#SPACESHIP_VI_MODE_COLOR=106

SPACESHIP_DIR_COLOR=66
SPACESHIP_DIR_LOCK_COLOR=167
SPACESHIP_EXEC_TIME_COLOR=214

SPACESHIP_CHAR_COLOR_SUCCESS=106
SPACESHIP_CHAR_COLOR_FAILURE=167

SPACESHIP_GIT_BRANCH_COLOR=132
SPACESHIP_GIT_STATUS_COLOR=167

# Julia
SPACESHIP_JULIA_COLOR=106

# virtualenv
SPACESHIP_VENV_COLOR=66
SPACESHIP_EXIT_CODE_COLOR=167

#=========================== Theme Custimization =============================

# using fzf and ripgrep
export FZF_COMPLETION_TRIGGER=';;'
export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='rg --column --line-number --no-heading --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '

# open a file with neovim using a fuzzy finder on the current directory
open_project_file() {
  target=$(fzf)
  if [[ $target != '' ]]; then
    nvim $(echo $target)
  fi
}
bindkey -s '^o' 'open_project_file\n'

# auto suggestion accept = TAB
#bindkey '^M' autosuggest-execute

# functions
for function in ~/.zsh/functions/*; do
  source $function
done

# better cd command
eval "$(zoxide init zsh)"

#
[[ $TMUX != "" ]] && export TERM="screen-256color"
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] &&  source ~/.zshrc.local
[ -f ~/.config/fzf/.fzf.zsh ] && source ~/.config/fzf/.fzf.zsh
[ -f ~/.config/lf/lf.zsh ] && source ~/.config/lf/lf.zsh

# pnpm
export PNPM_HOME="/home/dms449/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
# pnpm end

# bun completions
[ -s "/home/dms449/.bun/_bun" ] && source "/home/dms449/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
