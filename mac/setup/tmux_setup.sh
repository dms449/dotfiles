#!/bin/bas

printf "\n ============================================================\n"
printf "                     Setting up tmux"
printf "\n============================================================\n"

# install
if $INSTALL; then
  printf "\t Installing tmux and dependencies...\n"
  # tmux
  sudo $PM install tmux tmate xclip
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

fi

cd "${DOTFILES_HOME}/dotfiles/tmux"

stow --target="$HOME" .

printf "==================== tmux setup complete ====================\n\n"

cd "$DOTFILES_SETUP"

