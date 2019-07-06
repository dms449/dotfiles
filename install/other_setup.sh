#!/bin/shell

printf "Setting up other\n"

# install 
if $INSTALL; then
  # install xdotool
  sudo apt install xdotool
fi

cd "$HOME/dotfiles/dotfiles/other"

# symlink
files=(".focus_terminal.sh")
printf "\tSymlinking other files...\n"
for f in ${files[@]}; do
  if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git" ]; then
    symlink $(readlink -e "$f") "${HOME}/$f"
  fi
done

cd "$DOTFILES_INSTALL"
