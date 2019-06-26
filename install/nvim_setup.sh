#!/bin/bas

echo "Setting up nvim"

# install
if $INSTALL; then 
  echo "\t Installing neovim and dependencies..."
  # neovim
  sudo apt install neovim

  # neovim plugin manager
  sudo apt install curl
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  sudo apt install sil

  # for fuzzy finding within repository
  sudo apt install silversearcher-ag
fi


cd 
# symlink files
echo "\tSymlinking nvim files..."
for f in "$HOME"/dotfiles/dotfiles/nvim; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

echo "Done."

