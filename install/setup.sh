#!/bin/bash

# all of the indidivual project setup scripts
#source ./*.sh

# define this directory 
SETUP_DIR=$PWD

# determine whether or not to try to install necessary software in addition to 
# symlinking the dotfiles
INSTALL=false

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


# run! 
# --------------------------------------------------------------------
# sets up the specified packages. By default this does NOT install
# any packages (see 'install' function). This method by itself will
# only create the symlinks.
setup() {
  # initialize
  init 

  if [ $# -eq 0 ];  then
    # if no arguments, setup everything
    bash zsh_setup.sh
    bash tmux_setup
    bash nvim_setup.sh.sh
    bash other_setup.sh

  else
    # only setup the software that was passed in by name

    # iterate over passed parameters
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
  fi
}

# install
# --------------------------------------------------------------------
# This function simply sets INSTALL to true before setting up. This will 
# direct each setup script to also install required software.
install() {
  INSTALL=true
  setup "$@"
}


"$@"


