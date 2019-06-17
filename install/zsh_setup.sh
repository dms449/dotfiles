#!/bin/bas
source ./setup.sh

# do any basic initialization
init()

cd "$HOME"/dotfiles/dotfiles/zsh

# symlink files
echo "Symlinking zsh files ..."
for f in .* ; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

echo "Done."

