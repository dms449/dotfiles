# use Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi

#=========================== Theme Custimization =============================
# override some theme related zsh settings
SPACESHIP_PROMPT_ORDER=(
  user
  dir
  julia
  docker
  aws
  pyenv
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
SPACESHIP_VI_MODE_COLOR=34

SPACESHIP_DIR_COLOR="24"


SPACESHIP_CHAR_COLOR_SUCCESS=34
SPACESHIP_CHAR_COLOR_FAILURE=124


#=========================== Theme Custimization =============================

# using fzf and ripgrep
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'
export FZF_CTRL_T_COMMAND='rg --column --line-number --no-heading --fixed-strings --ignore-case --no-ignore --hidden --follow --glob "!.git/*" --color "always" '
bindkey -s '^o' 'nvim $(fzf)\n'
#
#
#
[[ $TMUX != "" ]] && export TERM="screen-256color"
[[ -f ~/.aliases ]] && source ~/.aliases
[[ -f ~/.zshrc.local ]] &&  source ~/.zshrc.local
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh



