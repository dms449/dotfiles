#!/bin/bash

# detect which package manager to use in descending order of preference 
pms=("yum" "apt" "apt-get" "pacman")
for pm in ${pms[@]}; do 
  type $pm
  if [ $? == 0 ]; then
    export PM="$pm"
    echo "Using $pm as package manager."
    break
  fi
done


type snap
[[ $? == 0 ]] && USE_SNAP=true || USE_SNAP=false



# this is the directory where the install scripts live and should always be
# the directory from which they are called.
export DOTFILES_INSTALL=$PWD 

# the root 'dotfiles' project directory
export DOTFILES_HOME="${DOTFILES_INSTALL}/.."
echo "dotfiles home = $DOTFILES_HOME"

# determine whether or not to try to install necessary software in addition to 
# symlinking the dotfiles
export INSTALL=false

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
export -f symlink

# prerequisites to install
# ---------------------------------------------------------------
prereqs() {
  # make sure everything is up to date first
  sudo $PM update

  # before installing anything, ensure that correct repositories are added to
  # the appropriate package managers
  if [ $PM=="yum" ]; then
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum install epel-release
  elif [ $PM=="apt" || $PM=="apt-get" ]; then
    sudo add-apt-repository ppa:x4121/ripgrep
  fi

  # install a bunch of stuff
  sudo $PM install git curl fonts-powerline python-pip python3-pip tig texlive-latex-extras acpi ripgrep

  # install usefule packages which have no configuration and are to be
  # used by other installed packages
  
}
export -f prereqs

# run! 
# --------------------------------------------------------------------
# sets up the specified packages. By default this does NOT install
# any packages (see 'install' function). This method by itself will
# only create the symlinks.
setup() {
  # initialize
  init 

  if [ $# -eq 0 ];  then

    # install the prereqs
    if [ $INSTALL ]; then
      prereqs
    fi

    # if no arguments, setup everything
    bash zsh_setup.sh
    bash tmux_setup.sh
    bash vim_setup.sh
    bash nvim_setup.sh
    bash other_setup.sh
    bash git_setup.sh
    # bash vscode_setup.sh
    bash fzf_setup.sh

  else
    # only setup the software that was passed in by name

    # iterate over passed parameters
    for var in "$@"
    do
      case "$var" in
        zsh) bash zsh_setup.sh ;;
        vim) bash vim_setup.sh ;;
        nvim)  bash nvim_setup.sh ;;
        tmux) bash tmux_setup.sh ;;
        other) bash other_setup.sh ;;
        vscode) bash vscode_setup.sh ;;
        git) bash git_setup.sh ;;
        fzf) bash fzf_setup.sh ;;
        prereqs) prereqs ;;
        
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


