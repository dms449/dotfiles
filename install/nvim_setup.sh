#!/bin/bash
source ./setup.sh

# do any basic initialization
init

# set the source directory for this
SOURCE="$HOME"/dotfiles/dotfiles/nvim

mkdir  ~/.config/nvim/
ln -s "${SOURCE}"/init.vim "~/.config/nvim/init.vim"
