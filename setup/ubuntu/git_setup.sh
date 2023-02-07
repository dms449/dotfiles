#!/bin/bas

printf "\n=============================================================\n"
printf "                    Setting up git\n"
printf "=============================================================\n"

# install
if $INSTALL; then
  sudo apt install gh
fi


cd "${DOTFILES_HOME}/dotfiles/git"
# symlink files

symlink $(readlink -e "config.yml") "${HOME}/.config/gh/config.yml"
symlink $(readlink -e ".gitconfig") "${HOME}/.gitconfig"

printf "=================== git setup complete ====================\n"
cd "$DOTFILES_SETUP"
