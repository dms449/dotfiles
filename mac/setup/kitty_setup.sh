#!/bin/bas
printf "\n ============================================================\n"
printf "                     Setting up kitty"
printf "\n============================================================\n"

DEST="${HOME}/.config/kitty"
mkdir $DEST

# install
if $INSTALL; then
  printf "\t Installing kitty and dependencies...\n"
  $PM install kitty
fi

cd "${DOTFILES_HOME}/dotfiles/kitty"
stow --adopt -t "$DEST" -d "${DOTFILES_HOME}/dotfiles" kitty

printf "====================kitty setup complete ====================\n"

cd "$DOTFILES_SETUP"
