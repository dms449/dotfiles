#!/bin/bash
printf "\n ============================================================\n"
printf "                     Setting up fzf\n"
printf "============================================================\n"


FZF_DEST="${HOME}/.config/fzf"
mkdir ${FZF_DEST}

# install
if $INSTALL; then
  printf "\t Installing fzf ...\n"
  mkdir -p ~/.fzf
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --bin
fi

# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles/fzf"

# symlink files
printf "\tSymlinking fzf files...\n"
files=(".fzf.zsh" "completion.zsh" "key-bindings.zsh")
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then
      symlink $(readlink -e "$f") "${FZF_DEST}/$f"
    fi
done

printf "====================fzf setup complete ====================\n"

unset FZF_DEST
cd "$DOTFILES_SETUP"

