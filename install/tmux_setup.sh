#!/bin/bas

printf "\n ============================================================\n"
printf "                     Setting up tmux\n"
printf "============================================================\n"

# install
if $INSTALL; then 
  printf "\t Installing tmux and dependencies...\n"
  # tmux
  sudo apt install tmux

  # theme 
  git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
fi

cd "${DOTFILES_HOME}/dotfiles/tmux"

# symlink files
files=(".tmux.conf")
printf "\tSymlinking tmux files...\n"
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

printf "==================== tmux setup complete ====================\n"

cd "$DOTFILES_INSTALL"
