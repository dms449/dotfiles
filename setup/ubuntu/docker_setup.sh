#!/bin/bash
printf "\n ============================================================\n"
printf "                     Setting up docker\n"
printf "============================================================\n"


# install
if $INSTALL; then
  printf "\t Installing Docker and dependencies...\n"

  # remove old ones
  sudo apt-get remove docker docker-engine docker.io containerd runc

  # get the official docker gpg key
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

  # setup the stable repository
  echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

  # install docker
  sudo apt-get update
  sudo apt-get install docker-ce docker-ce-cli containerd.io

  # download current stable release and add execute permissions
  sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
  sudo chmod +x /usr/local/bin/docker-compose

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
