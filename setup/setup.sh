#!/bin/bash

# Find the dotfile home
SCRIPT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
export DOTFILES_SETUP=$SCRIPT_DIR
export DOTFILES_HOME=$(realpath ${DOTFILES_SETUP}/..)
echo "Dotfiles home:    $DOTFILES_HOME"


export ME=$(whoami | awk '{print $1}')
export HOME="/home/$ME"
echo "User:             $ME  $HOME"

# Determine OS platform
# --------------------- UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME
echo "Detected OS:      $DISTRO"


# get the right package manager and system base based on distro
# ----------------------------------------------
export PM="apt"

echo "Package Manager:  $PM"
echo "------------------------------------------------------------\n\n"

# determine whether or not to try to install necessary software in addition to
# symlinking the dotfiles
export INSTALL=false

# run first
# -----------------------------------------------------------------
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
install_general_purpose() {
  # make sure everything is up to date first
  sudo $PM update

  # install a bunch of stuff
  sudo $PM install git curl python3-pip python3-venv tig acpi lsscsi openssh-server

  sudo $PM install lsb-release ca-certificates gnupg

  # pnpm
  sudo curl -fsSL "https://github.com/pnpm/pnpm/releases/latest/download/pnpm-linuxstatic-x64" -o /usr/local/bin/pnpm
  sudo chmod +x /usr/local/bin/pnpm;
  mkdir -p $HOME/.local/share/pnpm

  #lazygit
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin

  # nerd font
  wget -P $HOME/.local/share/fonts https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Hack.zip
  cd $HOME/.local/share/fonts && unzip Hack.zip && rm *Windows* && rm Hack.zip && cd $DOTFILES_SETUP
  fc-cache -fv

  # Google Chrome
  wget -P /home/$USER/Downloads https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
  sudo $PM install /home/$USER/Downloads/google-chrome-stable_current_amd64.deb

}
# export -f install_general_purpose

# run!
# --------------------------------------------------------------------
# sets up the specified packages. By default this does NOT install
# any packages (see 'install' function). This method by itself will
# only create the symlinks.
setup() {
  # initialize
  init

  echo "install = $INSTALL"

  # install the prereqs
  # if [ $INSTALL = true ]; then
  #   install_general_purpose
  # fi


  # if no arguments, setup everything
  if [ $# -eq 0 ];  then
    # basics
    bash $DOTFILES_SETUP/ubuntu/zsh_setup.sh
    bash $DOTFILES_SETUP/ubuntu/tmux_setup.sh
    bash $DOTFILES_SETUP/ubuntu/btop_setup.sh
    bash $DOTFILES_SETUP/ubuntu/vim_setup.sh
    bash $DOTFILES_SETUP/ubuntu/nvim_setup.sh
    bash $DOTFILES_SETUP/ubuntu/other_setup.sh
    bash $DOTFILES_SETUP/ubuntu/git_setup.sh
    bash $DOTFILES_SETUP/ubuntu/fzf_setup.sh
    bash $DOTFILES_SETUP/ubuntu/docker_setup.sh
    bash $DOTFILES_SETUP/ubuntu/lf_setup.sh
    bash $DOTFILES_SETUP/ubuntu/enpass_setup.sh
    bash $DOTFILES_SETUP/ubuntu/lazy_setup.sh

    # conglomerates
    bash $DOTFILES_SETUP/ubuntu/web_setup.sh
    #bash ubuntu/data_science_setup.sh

  # if arguments ARE passed in, only setup/install those
  else
    # iterate over passed parameters
    for var in "$@"
    do
      case "$var" in
        zsh) bash $DOTFILES_SETUP/ubuntu/zsh_setup.sh;;
        tmux) bash $DOTFILES_SETUP/ubuntu/tmux_setup.sh;;
        btop) bash $DOTFILES_SETUP/ubuntu/btop_setup.sh;;
        vim) bash $DOTFILES_SETUP/ubuntu/vim_setup.sh;;
        nvim) bash $DOTFILES_SETUP/ubuntu/nvim_setup.sh;;
        other) bash $DOTFILES_SETUP/ubuntu/other_setup.sh;;
        git) bash $DOTFILES_SETUP/ubuntu/git_setup.sh;;
        fzf) bash $DOTFILES_SETUP/ubuntu/fzf_setup.sh;;
        web) bash $DOTFILES_SETUP/ubuntu/web_setup.sh ;;
        docker) bash $DOTFILES_SETUP/ubuntu/docker_setup.sh;;
        lf) bash $DOTFILES_SETUP/ubuntu/lf_setup.sh;;
        enpass) bash $DOTFILES_SETUP/ubuntu/enpass_setup.sh;;
        lazy) bash $DOTFILES_SETUP/ubuntu/lazy_setup.sh;;
        # data_science) bash ubuntu/data_science_setup.sh ;;

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

unset INSTALL

