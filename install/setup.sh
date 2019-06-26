#!/bin/bash

# all of the indidivual project setup scripts
#source ./*.sh

# determine whether or not to try to install necessary software in addition to 
# symlinking the dotfiles
INSTALL=true

# run first
init(){
  # create the '.config' directory if it doesn't exist
  mkdir -p ~/.config

  # do other general setup
  # ...
}

# Symlink a file
symlink() {
  cd "$HOME" || exit
  ORG=$1
  DST=$2
  echo "Symlinking: ${ORG} -> ${DST}"
  if [[ -f $DST ]]; then
    mv "$DST" "${DST}".bak
  fi
  rm -f "$DST"
  ln -s "$ORG" "$DST"
  cd - >/dev/null 2>&1 || exit
}

all(){
  
}

# run! 
# --------------------------------------------------------------------
for var in "$@"
do
  case "$var" in
    zsh) bash zsh_setup.sh ;;
    nvim)  bash nvim_setup.sh ;;
    tmux) bash tmux_setup.sh ;;
    other) bash other_setup.sh ;;

    *) echo "Unrecognized software: $var" ;;
  esac
done


