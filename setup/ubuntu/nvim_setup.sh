#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up nvim\n"
printf '\n============================================================\n'

NVIM_DEST="${HOME}/.config/nvim"

# install
if $INSTALL; then
  printf "\t Installing neovim and dependencies...\n"

  printf "\t Installing Language Servers...\n"
  sudo pnpm add -g typescript n
  sudo n stable
  sudo pnpm add -g typescript-language-server bash-language-server dockerfile-language-server-nodejs vscode-langservers-extracted vue-language-server svelte-language-server

  sudo pip3 install pyright pynvim
  sudo apt install python3-venv

  # neovim
  printf "\t Installing Neovim...\n"
  mkdir ${NVIM_DEST}
  rm -f ${NVIM_DEST}/nvim.appimage
  curl -Lo ${NVIM_DEST}/nvim.appimage https://github.com/neovim/neovim/releases/download/nightly/nvim.appimage
  chmod a+rxw ${NVIM_DEST}/nvim.appimage
  sudo rm -f /usr/local/bin/nvim
  sudo ln -s ${NVIM_DEST}/nvim.appimage /usr/local/bin/nvim

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
