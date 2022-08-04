#!/bin/bash

printf '\n============================================================\n'
printf "                     Web stuff (NOT COMPLETE)\n"
printf '\n============================================================\n'

DOTFILE_DEST="${HOME}/.config/web"

# install
if $INSTALL; then
  sudo apt install npm

  # TODO: npm install javascript thing
  # TODO: other language servers
  sudo npm install -g typescript typescript-language-server bash-language-server dockerfile-language-server-nodejs
  sudo pip3 install pyright
  gem install --user-install solargraph
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
