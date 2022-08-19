#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up nvim\n"
printf '\n============================================================\n'

LF_DEST="${HOME}/.config/lf"

# install
if $INSTALL; then
  printf "\t Installing lf and dependencies...\n"
  mkdir ${LF_DEST} && cd ${LF_DEST}
  curl -Lo lf-linux-amd64.tar.gz https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz
  tar xvf lf-linux-amd64.tar.gz
  chmod +x lf
  sudo symlink "${LF_DEST}/lf" "/usr/local/bin/lf"

fi


cd "${DOTFILES_HOME}/dotfiles/lf"
# symlink files
# files=("init.lua" "lua" "colors" "UltiSnips" "plugin" "ftplugin")
printf "\tSymlinking nvim files...\n"
for f in * ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${LF_DEST}/$f"
    fi
done

printf "==================== nvim setup complete ====================\n"

unset LF_DEST
cd "$DOTFILES_SETUP"
