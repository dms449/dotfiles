#!/bin/bas

printf "\n ============================================================\n"
printf "                     Setting up vscode\n"
printf "\n ============================================================\n"

# install
if $INSTALL; then 
  printf "\t Installing vscode and dependencies...\n"
  # install some dependencies
  sudo apt install software-properties-common apt-transport-https wget

  # import Microsoft GPG key 
  wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -

  # enable the Visual Studio Code repository
  sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"

  # install vscode
  sudo apt install code

fi

cd "${DOTFILES_HOME}/dotfiles/vscode"

# symlink files
files=("Code/User/settings.json" "Code/User/keybindings.json")

# ensure directory exists
mkdir -p "${HOME}/.config/Code/User"
printf "\tSymlinking vscode files...\n"
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/.config/$f"
    fi
done

printf "==================== vscode setup complete ====================\n"

cd "$DOTFILES_SETUP"

