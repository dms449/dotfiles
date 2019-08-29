#!/bin/bas
printf "\n ============================================================\n"
printf "                     Setting up fzf\n"
printf "============================================================\n"


# define the directory where fzf config files will be kept and ensure it exists
FZF_CONFIG=${HOME}/.config/fzf
mkdir -p ${FZF_CONFIG}

# install
if $INSTALL; then 
  printf "\t Installing fzf and dependencies...\n"
  # fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles/fzf"

# symlink files
printf "\tSymlinking fzf files...\n"
files=(".fzf.zsh" ".fzf.bash") 
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

files=("shell")
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/.config/fzf/$f"
    fi
done

printf "====================fzf setup complete ====================\n"

cd "$DOTFILES_INSTALL"
