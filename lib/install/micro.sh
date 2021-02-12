#!/usr/bin/env bash
# shellcheck source=/dev/null
. "$HOME/.dotfiles/lib/.utils/utilities.sh"

INSTALL_FROM_GIT() {
  git clone https://github.com/zyedidia/micro
  cd micro || ERROR
  make build
  sudo mv micro '/usr/local/bin/'
  cd .. && rm -rf micro || return 0
}
INSTALL() {
  echo "Installing Micro Editor"
  if CMD apt; then
    sudo apt-get install -y micro || ERROR
  else
    INSTALL_FROM_GIT
  fi
}
echo "Install requires 'sudo' access, continue?"
if CONTINUE; then
  INSTALL
else
  echo "Install cancelled"
fi
