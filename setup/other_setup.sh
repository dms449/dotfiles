#!/bin/shell

printf "\n ============================================================\n"
printf "                     Setting up other\n"
printf "============================================================\n"

# install 
if $INSTALL; then
  # install xdotool
  sudo apt install xdotool
  sudo apt install ctags
fi

cd "$HOME/dotfiles/dotfiles/other"

# symlink
files=("focus_terminal.sh" ".ctags")
printf "\tSymlinking other files...\n"
for f in ${files[@]}; do
  if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git" ]; then
    symlink $(readlink -e "$f") "${HOME}/$f"
  fi
done


printf "==================== other setup complete ====================\n"

cd "$DOTFILES_INSTALL"
