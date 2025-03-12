printf "\n ============================================================\n"
printf "                     Setting up codium\n"
printf "============================================================\n"

if $INSTALL; then
  printf "\t Installing windsurf...\n"

  curl -fsSL "https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/windsurf.gpg" | sudo gpg --dearmor -o /usr/share/keyrings/windsurf-stable-archive-keyring.gpg
  echo "deb [signed-by=/usr/share/keyrings/windsurf-stable-archive-keyring.gpg arch=amd64] https://windsurf-stable.codeiumdata.com/wVxQEIWkwPUEAGf3/apt stable main" | sudo tee /etc/apt/sources.list.d/windsurf.list > /dev/null
  sudo $PM update
  sudo $PM install windsurf
fi

# change to the src directory so we can symlink the files
cd "${DOTFILES_HOME}/dotfiles"
stow codium
cd "$DOTFILES_SETUP"
