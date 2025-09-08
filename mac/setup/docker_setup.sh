#!/bin/bash
printf "\n ============================================================\n"
printf "                     Setting up docker\n"
printf "============================================================\n"


# install
if $INSTALL; then
  printf "\t Installing Docker and dependencies...\n"

  # remove old ones
  sudo apt remove docker docker-engine docker.io containerd runc docker-compose-plugin

  # get the official docker gpg key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  # setup the stable repository
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # install docker
  sudo apt update
  sudo apt install docker-ce docker-ce-cli containerd.io docker-compose-plugin

  # add docker group and add user to it (prevents having to run 'sudo' all the time)
  sudo groupadd docker
  sudo gpasswd -a $USER docker
  newgrp docker

fi


# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles/docker"

# symlink files
printf "\tSymlinking docker files...\n"
files=()
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${HOME}/.fzf/$f"
    fi
done

printf "====================docker setup complete ====================\n"

cd "$DOTFILES_SETUP"
