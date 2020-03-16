#!/bin/bash

printf "\n============================================================\n"
printf "                     Setting up vim\n"
printf "\n============================================================\n"

# install
#if $INSTALL; then 
#  # nothing to install
#fi

cd "${DOTFILES_HOME}/dotfiles/vim"
# symlink files
files=(".vimrc")
printf "\tSymlinking vim files...\n"
for f in ${files[@]} ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      printf "file = $f\n"
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

printf "==================== vim setup complete ===================="

cd "$DOTFILES_INSTALL"
