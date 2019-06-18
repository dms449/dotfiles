#!/bin/shell
source ./setup.sh

# do any basic initialization
init

# set the source directory for this
SOURCE="$HOME"/dotfiles/dotfiles/other

# install xdotool
if ["$INSTALL"=true] ; then
  sudo apt install xdotool
fi

# symlink
ln -s "$SOURCE"/.focusterminal.sh ~/.focusterminal.sh
