#!/bin/shell

printf "Setting up other\n"

# install 
if $INSTALL; then
  # install xdotool
  sudo apt install xdotool
fi

cd "$HOME"/dotfiles/dotfiles/other

# symlink
printf "\tSymlinking other files...\n"
for f in . ; do
  if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git" ]; then
    symlink $(readlink -e "$f") "${HOME}/$f"
  fi
done

cd "$SETUP_DIR"
