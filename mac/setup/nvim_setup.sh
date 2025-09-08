#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up nvim"
printf '\n============================================================\n'

NVIM_DEST="${HOME}/.config/nvim"

# install
if $INSTALL; then
  printf "\t Installing neovim and dependencies...\n"

  # neovim
  $PM install neovim
fi

cd "${DOTFILES_HOME}/dotfiles/nvim"
stow --target="$NVIM_DEST" .

printf "==================== nvim setup complete ====================\n\n"

unset NVIM_DEST
cd "$DOTFILES_SETUP"
