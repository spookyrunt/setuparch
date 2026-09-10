#!/bin/bash
set -euo pipefail

sudo pacman -Syu --needed base-devel \
  git unzip jq ripgrep fd fzf trash-cli \
  python python-pip nodejs npm rustup \
  etckeeper

./setup-nvim.sh
./setup-go.sh

echo ""
echo "Finished. Please reboot."
