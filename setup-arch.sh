#!/bin/bash
set -euo pipefail

sudo pacman -Syu --needed base-devel \
  less unzip curl \
  git jq ripgrep fd fzf trash-cli \
  python python-pip nodejs npm rustup \
  etckeeper

# setup yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
(
  cd /tmp/yay
  makepkg -si
)
rm -rf /tmp/yay

./setup-nvim.sh
./setup-go.sh
./setup-snapper.sh

# setup lemonade
go install github.com/lemonade-command/lemonade@latest

# setup etckeeper
sudo etckeeper init
sudo sed -i 's/^#* *AVOID_DAILY_AUTOCOMMITS=.*/AVOID_DAILY_AUTOCOMMITS=1/' /etc/etckeeper/etckeeper.conf
sudo systemctl mask --now etckeeper.timer

echo ""
echo "Finished. Please reboot."
