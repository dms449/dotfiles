#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up btop\n"
printf '\n============================================================\n'

BTOP_DEST="${HOME}/.config/btop"
mkdir $BTOP_DEST

# install
if $INSTALL; then
  printf "\t Installing btop and dependencies...\n"
  $PM install btop
fi

stow -t "$BTOP_DEST" -d "${DOTFILES_HOME}/dotfiles" btop

printf "==================== btop setup complete ====================\n"

unset BTOP_DEST
cd "$DOTFILES_SETUP"
