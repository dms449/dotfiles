#!/bin/bas

printf "Setting up nvim\n"

# install
if $INSTALL; then 
  printf "\t Installing neovim and dependencies...\n"
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


cd "$HOME"/dotfiles/dotfiles/nvim
# symlink files
printf "\tSymlinking nvim files...\n"
for f in . ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

cd "$SETUP_DIR"
