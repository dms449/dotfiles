#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up nvim\n"
printf '\n============================================================\n'

TARGET="${DOTFILES_HOME}/dotfiles/nvim"
DEST="${HOME}/.config/nvim"

# install
if $INSTALL; then
  printf "\t Installing neovim and dependencies...\n"

  # neovim
  printf "\t Installing Neovim...\n"
  mkdir ${DEST}
  rm -f ${DEST}/nvim.appimage
  curl -Lo ${DEST}/nvim.appimage https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
  chmod a+rxw ${DEST}/nvim.appimage
  sudo rm -f /usr/local/bin/nvim
  sudo ln -s ${DEST}/nvim.appimage /usr/local/bin/nvim

fi

stow --target="$DEST" .

printf "==================== nvim setup complete ====================\n"

unset DEST
