#!/bin/bas

printf "\n=============================================================\n"
printf "                    Setting up git\n"
printf "=============================================================\n"

# install
if $INSTALL; then
  # nothing to install
  echo "nothing to install."
fi


cd "${DOTFILES_HOME}/dotfiles/git"
# symlink files
files=(".gitconfig")
printf "\tSymlinking git files...\n"
for f in ${files[@]} ; do
  if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
    symlink $(readlink -e "$f") "${HOME}/$f"
  fi
done

printf "=================== git setup complete ====================\n"
cd "$DOTFILES_INSTALL"
