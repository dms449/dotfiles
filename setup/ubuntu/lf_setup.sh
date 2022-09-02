#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up lf file manager\n"
printf '\n============================================================\n'

LF_DEST="${HOME}/.config/lf"

# install
if $INSTALL; then
  printf "\t Installing lf and dependencies...\n"
  mkdir -p ${LF_DEST} && cd ${LF_DEST}
  curl -Lo lf-linux-amd64.tar.gz https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz
  tar xvf lf-linux-amd64.tar.gz
  chmod +x lf
  sudo ln -s "${LF_DEST}/lf" "/usr/local/bin/lf"

  cd "${HOME}/.config/"
  sudo apt install libmagic-dev libssl-dev libxext-dev
  pip install ueberzug
  git clone https://github.com/NikitaIvanovV/ctpv
  sudo make install
fi


cd "${DOTFILES_HOME}/dotfiles/lf"
# symlink files
printf "\tSymlinking files...\n"
for f in * ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${LF_DEST}/$f"
    fi
done
symlink "${DOTFILES_HOME}/dotfiles/lf/ctpv/config" "${HOME}/.config/ctpv/config"

printf "==================== lf setup complete ====================\n"

unset LF_DEST
cd "$DOTFILES_SETUP"
