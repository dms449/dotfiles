#!/bin/bash
printf "\n ============================================================\n"
printf "                     Setting up fzf\n"
printf "============================================================\n"


# install
if $INSTALL; then
  if [ -d ~/.fzf ]; then
    echo "~/.fzf already exists. skipping fzf install"
  else
    printf "\t Installing fzf ...\n"
    mkdir -p ~/.fzf/fzf
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf/fzf
    ~/.fzf/fzf/install --bin
  fi

  printf "\t Installing ripgrep ...\n"
  if [ $PM=="yum" ]; then
    sudo yum-config-manager --add-repo=https://copr.fedorainfracloud.org/coprs/carlwgeorge/ripgrep/repo/epel-7/carlwgeorge-ripgrep-epel-7.repo
    sudo yum install epel-release
  elif [ $PM=="apt" || $PM=="apt-get" ]; then
    sudo add-apt-repository ppa:x4121/ripgrep
  fi
  sudo apt update
  sudo apt install ripgrep

fi

# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles/fzf"

# symlink files
printf "\tSymlinking fzf files...\n"
files=(".fzf.zsh" "completion.zsh" "key-bindings.zsh")
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${HOME}/.fzf/$f"
    fi
done

printf "====================fzf setup complete ====================\n"

cd "$DOTFILES_SETUP"
