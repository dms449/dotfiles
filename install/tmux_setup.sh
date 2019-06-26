#!/bin/bas

echo "Setting up tmux"

# install
if $INSTALL; then 
  echo "\t Installing tmux and dependencies..."
  # tmux
  sudo apt install tmux

  # theme 
  git clone https://github.com/jimeh/tmux-themepack.git ~/.tmux-themepack
fi


cd 
# symlink files
echo "\tSymlinking tmux files..."
for f in "$HOME"/dotfiles/dotfiles/tmux; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

echo "Done."

