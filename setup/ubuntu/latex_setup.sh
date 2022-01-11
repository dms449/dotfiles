#!/bin/bas
printf "\n ============================================================\n"
printf "                     Setting up latex\n"
printf "============================================================\n"

# install
if $INSTALL; then 
  printf "\t Installing latex and dependencies...\n"

  # install stuff
  sudo apt install texlive-latex-extra

fi

# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles/latex"
# symlink files
files=()
printf "\tSymlinking latex files...\n"
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

printf "====================latex setup complete ====================\n"

cd "$DOTFILES_SETUP"
