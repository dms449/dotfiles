#!/bin/shell

printf "\n ============================================================\n"
printf "                     Setting up other\n"
printf "============================================================\n"

# install
if $INSTALL; then
  # install xdotool
  sudo apt install xdotool gnome-tweaks

  #nfs stuff
  sudo apt install nfs-common cifs-utils
fi

cd "$HOME/dotfiles/dotfiles/other"

# load settings file
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf

# symlink
files=(".ctags")
printf "\tSymlinking other files...\n"
for f in ${files[@]}; do
  if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git" ]; then
    symlink $(readlink -e "$f") "${HOME}/$f"
  fi
done


printf "==================== other setup complete ====================\n"

cd "$DOTFILES_SETUP"
