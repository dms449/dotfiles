# use zPrezto if it exists
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

# use autojump.sh if it exists
if [[ -s "/usr/share/autojump/autojump.zsh" ]]; then
  source "/usr/share/autojump/autojump.zsh"
fi

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
SPACESHIP_VI_MODE_COLOR=106

SPACESHIP_DIR_COLOR=66
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
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '

# open a file with neovim using a fuzzy finder on the current directory
bindkey -s '^o' 'nvim $(fzf)\n'

# auto suggestion accept = TAB
#bindkey '^M' autosuggest-execute

#
#
#
[[ $TMUX != "" ]] && export TERM="screen-256color"
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] &&  source ~/.zshrc.local
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh


