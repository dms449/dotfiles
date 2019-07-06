#!/bin/bas

printf "Setting up vim\n"

# install
if $INSTALL; then 
  # nothing to install
fi

cd "${DOTFILES_HOME}/dotfiles/nvim"
# symlink files
files=(".vimrc")
printf "\tSymlinking vim files...\n"
for f in ${files[@]} ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

cd "$DOTFILES_INSTALL"
