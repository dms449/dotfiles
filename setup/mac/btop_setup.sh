#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up btop\n"
printf '\n============================================================\n'

BTOP_DEST="${HOME}/.config/btop"

# install
if $INSTALL; then
  printf "\t Installing btop and dependencies...\n"
  sudo apt install btop
fi

cd "${DOTFILES_HOME}/dotfiles/btop"
# symlink files
printf "\tSymlinking files...\n"
for f in * ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${BTOP_DEST}/$f"
    fi
done

printf "==================== btop setup complete ====================\n"

unset BTOP_DEST
cd "$DOTFILES_SETUP"
