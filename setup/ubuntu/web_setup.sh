#!/bin/bash

printf '\n============================================================\n'
printf "                     Web stuff (NOT COMPLETE)\n"
printf '\n============================================================\n'

DOTFILE_DEST="${HOME}/.config/web"

# install
if $INSTALL; then
  sudo apt install ruby-full

  # TODO: pnpm install javascript thing
  # TODO: other language servers
  gem install --user-install solargraph
  gem install --user-install neovim

  curl -fsSL https://bun.sh/install | bash
fi



cd "${DOTFILES_HOME}/dotfiles/web"
# symlink files
files=()
printf "\tSymlinking web related files...\n"
for f in ${files[@]} ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${DOTFILE_DEST}/$f"
    fi
done

printf "==================== web setup complete ====================\n"

cd "$DOTFILES_SETUP"
