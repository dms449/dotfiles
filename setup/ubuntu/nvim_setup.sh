#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up nvim\n"
printf '\n============================================================\n'

NVIM_DEST="${HOME}/.config/nvim"

# install
if $INSTALL; then
  printf "\t Installing neovim and dependencies...\n"

  printf "\t Installing Language Servers...\n"
  sudo npm i -g bash-language-server
  sudo npm i -g vscode-langservers-extracted
  sudo gem install --user-install solargraph

  pip3 install pyright
  pip3 install pynvim

  # neovim
  printf "\t Installing Neovim...\n"
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
# files=("init.lua" "lua" "colors" "UltiSnips" "plugin" "ftplugin")
printf "\tSymlinking nvim files...\n"
for f in * ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${NVIM_DEST}/$f"
    fi
done

printf "==================== nvim setup complete ====================\n"

unset NVIM_DEST
cd "$DOTFILES_SETUP"
