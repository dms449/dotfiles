#!/bin/bas

printf "\n=============================================================\n"
printf "                    Setting up git\n"
printf "=============================================================\n"

# install
if $INSTALL; then
  brew install gh git-flow lazygit
fi

cd "${DOTFILES_HOME}/git"
# symlink files

mkdir -p "${HOME}/.config/gh" "${HOME}/.config/lazygit"

cd "${DOTFILES_HOME}/dotfiles/git"
symlink $(readlink -f ".gitconfig") "${HOME}/.gitconfig"
stow --target="${HOME}/.config" .

printf "=================== git setup complete ====================\n"
cd "$DOTFILES_SETUP"
