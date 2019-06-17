#!/bin/bas
source ./setup.sh

cd "$HOME"/dotfiles/dotfiles/zsh

# symlink files
echo "Symlinking zsh files ..."
for f in .* ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done
echo "Done."

