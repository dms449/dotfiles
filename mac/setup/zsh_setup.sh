#!/bin/bas
printf "\n ============================================================\n"
printf "                     Setting up zsh"
printf "\n============================================================\n"

# install
if $INSTALL; then
  printf "\t Installing zsh and dependencies...\n"

  # install stuff
  $PM install zoxide ripgrep

  # zprezto (zsh framework)
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
  git clone --recurse-submodules https://github.com/belak/prezto-contrib "${HOME}/.zprezto/contrib"
fi

cd "${DOTFILES_HOME}/dotfiles/zsh"
stow --target="$HOME" .

printf "====================zsh setup complete ====================\n"

cd "$DOTFILES_SETUP"
