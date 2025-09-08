#!/bin/bash

printf '\n============================================================\n'
printf "                     Setting up lazy terminal tools\n"
printf '\n============================================================\n'

# install
if $INSTALL; then
  #lazygit
  LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
  curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
  tar xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm lazygit.tar.gz lazygit

  curl https://raw.githubusercontent.com/jesseduffield/lazydocker/master/scripts/install_update_linux.sh | bash
fi


cd "${DOTFILES_HOME}/dotfiles/lazy"
for dir in * ; do
  if [ -d "$dir" ]; then
    mkdir -p "${HOME}/.config/$dir"
    echo "dir=$dir"
    for f in $(find $dir -maxdepth 1 -type f); do
      echo "file=$f"
      symlink $(readlink -e "$f") "${HOME}/.config/$f"
    done
  fi
done

printf "==================== lazy setup complete ====================\n"
cd "$DOTFILES_SETUP"
