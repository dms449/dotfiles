#!/bin/bas

printf "\n=============================================================\n"
printf "                    Setting up git\n"
printf "=============================================================\n"

# install
if $INSTALL; then
  brew install gh git-flow lazygit
fi


cd "${DOTFILES_HOME}/dotfiles/git"
# symlink files

mkdir -p "${HOME}/.config/gh"
symlink $(readlink -f "config.yml") "${HOME}/.config/gh/config.yml"
symlink $(readlink -f ".gitconfig") "${HOME}/.gitconfig"

printf "=================== git setup complete ====================\n"
cd "$DOTFILES_SETUP"
