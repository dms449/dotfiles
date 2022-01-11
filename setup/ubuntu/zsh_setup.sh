#!/bin/bas
printf "\n ============================================================\n"
printf "                     Setting up zsh\n"
printf "============================================================\n"

# install
if $INSTALL; then 
  printf "\t Installing zsh and dependencies...\n"

  # install stuff
  sudo $PM install zsh autojump

  # zprezto (zsh framework)
  git clone --recursive https://github.com/sorin-ionescu/prezto.git "${HOME}/.zprezto"
  git clone --recurse-submodules https://github.com/belak/prezto-contrib "${HOME}/.zprezto/contrib"
fi

# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles/zsh"
# symlink files
files=(".aliases" ".zlogin" ".zlogout" ".zpreztorc" ".zprofile" ".zsh" ".zshenv" ".zshrc")
printf "\tSymlinking zsh files...\n"
for f in ${files[@]}; do
    if [ "$f" != ".." ] && [ "$f" != "." ] && [ "$f" != ".git*" ]; then 
      symlink $(readlink -e "$f") "${HOME}/$f"
    fi
done

printf "====================zsh setup complete ====================\n"

cd "$DOTFILES_SETUP"
