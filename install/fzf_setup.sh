#!/bin/bas
printf "\n ============================================================\n"
printf "                     Setting up fzf\n"
printf "============================================================\n"

# install
if $INSTALL; then 
  printf "\t Installing fzf and dependencies...\n"
  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install

fi

# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles/fzf"
# symlink files
files=(".fzf.zsh" ".fzf.bash")
printf "\tSymlinking fzf files...\n"
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

printf "====================fzf setup complete ====================\n"

cd "$DOTFILES_INSTALL"
