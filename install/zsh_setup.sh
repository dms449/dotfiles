#!/bin/bas

printf "Setting up zsh\n"

# install
if $INSTALL; then 
  printf "\t Installing zsh and dependencies...\n"
  # zsh
  sudo apt install zsh

  # zprezto (zsh framework)
  sudo apt insall fonts-powerline
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
  git clone --recurse-submodules https://github.com/belak/prezto-contrib "${ZPREZTODIR:-$HOME}/contrib"
fi

# change to the src directory so we can symlink the files
cd "$HOME"/dotfiles/dotfiles/zsh

# symlink files
printf "\tSymlinking zsh files...\n"
for f in . ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

cd "$SETUP_DIR"
