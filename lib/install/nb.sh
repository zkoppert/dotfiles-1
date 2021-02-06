#!/usr/bin/env bash
# shellcheck source=/dev/null
. "$HOME/.dotfiles/lib/.utils/utilities.sh"

INSTALL() {
  echo "Installing NoteBook (nb.sh)"
  if CMD npm; then
    npm install -g nb.sh
    sudo "$(which nb)" completions install
  elif CMD brew; then
    brew install nb
  else
    sudo wget https://raw.github.com/xwmx/nb/master/nb -O /usr/local/bin/nb &&
      sudo chmod +x /usr/local/bin/nb &&
      sudo nb completions install --download
  fi
}
echo "Install requires 'sudo' access, continue?"
if CONTINUE; then
  INSTALL
else
  echo "Install cancelled"
fi
