#!/bin/bas

printf "Setting up zsh\n"

# install
if $INSTALL; then 
  printf "\t Installing zsh and dependencies...\n"
  # zsh
  sudo apt install zsh

  # zprezto (zsh framework)
  sudo apt insall fonts-powerline
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${$HOME}/.zprezto"
  git clone --recurse-submodules https://github.com/belak/prezto-contrib "${$HOME}/.zprezto/contrib"
fi

# change to the src directory so we can symlink the files
cd "${HOME}/dotfiles/dotfiles/zsh"
# symlink files
files=(".aliases" ".zlogin" ".zlogout" ".zpreztorc" ".zprofile" ".zsh" ".zshenv" ".zshrc")
printf "\tSymlinking zsh files...\n"
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

cd "$DOTFILES_INSTALL"
