#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up upterm \n"
printf '\n============================================================\n'

UPTERM_DEST="${HOME}/.config/upterm"

# install
if $INSTALL; then
  printf "\t Installing upterm and dependencies...\n"
  mkdir -p ${UPTERM_DEST} && cd ${UPTERM_DEST}

  curl -o upterm.tar.gz -LJ https://github.com/owenthereal/upterm/releases/download/v0.13.0/upterm_linux_386.tar.gz
  tar zxvf upterm.tar.gz
  sudo ln -s "${UPTERM_DEST}/upterm" "/usr/local/bin/upterm"
  rm -f upterm.tar.gz
fi
