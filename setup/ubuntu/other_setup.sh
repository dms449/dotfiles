#!/bin/shell

printf "\n ============================================================\n"
printf "                     Setting up other\n"
printf "============================================================\n"

# install
if $INSTALL; then
  # install xdotool
  sudo apt install xdotool
  sudo apt install ctags

  # lf terminal file manager
  mkdir ${LF_DEST}
  LF_DEST="${HOME}/.config/lf"
  cd ${LF_DEST}
  curl -Lo lf-linux-amd64.tar.gz https://github.com/gokcehan/lf/releases/download/r27/lf-linux-amd64.tar.gz
  tar xvf lf-linux-amd64.tar.gz
  chmod +x lf
  sudo symlink "${LF_DEST}/lf" "/usr/local/bin/lf"
fi

cd "$HOME/dotfiles/dotfiles/other"

# load settings file
dconf load /org/gnome/terminal/legacy/profiles:/ < gnome-terminal-profiles.dconf

# symlink
files=("focus_terminal.sh" ".ctags")
printf "\tSymlinking other files...\n"
for f in ${files[@]}; do
  if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git" ]; then
    symlink $(readlink -e "$f") "${HOME}/$f"
  fi
done


printf "==================== other setup complete ====================\n"

cd "$DOTFILES_SETUP"
