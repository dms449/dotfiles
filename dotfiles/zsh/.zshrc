# use Prezto
if [[ -s "${ZDOTDIR:-$HOME}/.zprezto/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprezto/init.zsh"
fi


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
  vi_mode
  jobs
  exit_code
  char
)
SPACESHIP_RPROMPT_ORDER=(
  git
  time
)

#SPACESHIP_PROMPT_PREFIXES_SHOW=false
SPACESHIP_EXIT_CODE_SHOW=true
#
#
#
#
[[ -f ~/.aliases ]] && source ~/.aliases
#[[ -f ~/.zshrc.local ]] &&  source ~/.zshrc.local
#[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



