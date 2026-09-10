#!/bin/bash
set -euo pipefail

sudo pacman -Syu --needed base-devel \
  less unzip curl \
  git jq ripgrep fd fzf trash-cli \
  python python-pip nodejs npm rustup \
  etckeeper

./setup-nvim.sh
./setup-go.sh

# setup etckeeper
sudo etckeeper init
sudo sed -i 's/^#* *AVOID_DAILY_AUTOCOMMITS=.*/AVOID_DAILY_AUTOCOMMITS=1/' /etc/etckeeper/etckeeper.conf
sudo systemctl mask --now etckeeper.timer

echo ""
echo "Finished. Please reboot."
