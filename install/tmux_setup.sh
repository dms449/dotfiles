#!/bin/bas

printf "Setting up tmux\n"

# install
if $INSTALL; then 
  printf "\t Installing tmux and dependencies...\n"
  # tmux
  sudo apt install tmux

  # theme 
  git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
fi

cd "$HOME"/dotfiles/dotfiles/tmux
# symlink files
printf "\tSymlinking tmux files...\n"
for f in . ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

cd "$SETUP_DIR"

