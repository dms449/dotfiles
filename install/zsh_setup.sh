#!/bin/bas

echo "Setting up zsh"

# install
if $INSTALL; then 
  echo "\t Installing zsh and dependencies..."
  # zsh
  sudo apt install zsh

  # zprezto (zsh framework)
  sudo apt insall fonts-powerline
#  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"
 # git clone --recurse-submodules https://github.com/belak/prezto-contrib "${ZPREZTODIR:-$HOME}/contrib"
fi


cd 
# symlink files
echo "\tSymlinking zsh files..."
for f in "$HOME"/dotfiles/dotfiles/zsh; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

echo "Done."

