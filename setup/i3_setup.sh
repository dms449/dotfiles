#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up i3\n"
printf '\n============================================================\n'

  #_DEST="${HOME}/.config/i3"

# install
if $INSTALL; then 
  printf "\t Installing i3 and dependencies...\n"

  sudo apt install i3blocks


fi


cd "${DOTFILES_HOME}/dotfiles/i3"
# symlink files
files=("i3")
printf "\tSymlinking i3 files...\n"
for f in ${files[@]} ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/.config/$f"
    fi
done

printf "==================== i3 setup complete ====================\n"

cd "$DOTFILES_INSTALL"
