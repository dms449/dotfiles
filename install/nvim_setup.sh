#!/bin/bas

printf '\n============================================================\n'
printf "                     Setting up nvim\n"
printf '\n============================================================\n'

# install
if $INSTALL; then 
  printf "\t Installing neovim and dependencies...\n"

  # neovim
  NVIM_DEST="${HOME}/.config/nvim"
  mkdir ${NVIM_DEST}
  curl -Lo ${NVIM_DEST}/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod a+rxw ${NVIM_DEST}/nvim.appimage
  symlink ${NVIM_DEST}/nvim.appimage /usr/local/bin/nvim

  # neovim plugin manager
  curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

  # for fuzzy finding within repository
  sudo apt install silversearcher-ag
fi


cd "${DOTFILES_HOME}/dotfiles/nvim"
# symlink files
files=("init.vim")
printf "\tSymlinking nvim files...\n"
for f in ${files[@]} ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${NVIM_DEST}/$f"
    fi
done

printf "==================== nvim setup complete ====================\n"

cd "$DOTFILES_INSTALL"
