#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up Enpass\n"
printf '\n============================================================\n'

if $INSTALL; then
  echo "deb https://apt.enpass.io/ stable main" | sudo tee -a /etc/apt/sources.list.d/enpass.list
  wget -O - https://apt.enpass.io/keys/enpass-linux.key | sudo tee /etc/apt/trusted.gpg.d/enpass.asc
  sudo apt update
  sudo apt install enpass
fi

