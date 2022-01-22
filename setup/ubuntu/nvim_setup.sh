#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up nvim\n"
printf '\n============================================================\n'

  NVIM_DEST="${HOME}/.config/nvim"

# install
if $INSTALL; then
  printf "\t Installing neovim and dependencies...\n"

  #sudo $PM install exuberant-ctags
# install language servers printf "\t Installing language servers\n"
  # python
  #pip3 install jedi
  #pip3 install pynvim

  # c/c++
  #sudo $PM install clang-tools-9
  #sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-8 100


  # neovim
  mkdir ${NVIM_DEST}
  curl -Lo ${NVIM_DEST}/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod a+rxw ${NVIM_DEST}/nvim.appimage
  symlink ${NVIM_DEST}/nvim.appimage /usr/local/bin/nvim

  # neovim plugin manager `Packer`
  git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim

fi


cd "${DOTFILES_HOME}/dotfiles/nvim"
# symlink files
# files=("init.vim" "colors" "UltiSnips" "plugin")
printf "\tSymlinking nvim files...\n"
for f in * ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${NVIM_DEST}/$f"
    fi
done

printf "==================== nvim setup complete ====================\n"

cd "$DOTFILES_SETUP"
