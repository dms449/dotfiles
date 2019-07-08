#!/bin/bas

printf "============================================================"
printf "                     Setting up vim\n"
printf "============================================================"

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

printf "==================== vim setup complete ===================="

cd "$DOTFILES_INSTALL"
