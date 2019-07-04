#!/bin/bas

printf "Setting up nvim\n"

# install
if $INSTALL; then 
  printf "\t Installing neovim and dependencies...\n"

  # neovim
  NVIM_DEST="${HOME}/.config/nvim/"
  mkdir ${NVIM_DEST}
  curl -Lo ${NVIM_DEST}/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod a+rxw ${NVIM_DEST}/nvim.appimage
  symlink ${NVIM_DEST}/nvim.appimage /usr/local/bin/nvim

  # neovim plugin manager
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
