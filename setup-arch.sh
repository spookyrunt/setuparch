#!/bin/bash
set -euo pipefail

sudo pacman -Syu --needed --noconfirm base-devel \
  less unzip curl \
  git jq ripgrep fd fzf trash-cli \
  python python-pip nodejs npm rustup \
  etckeeper btrfs-assistant \
  tree rsync

# setup rustup
rustup default stable

# setup ll
grep -qxF "alias ll='ls -alF'" ~/.bashrc || echo "alias ll='ls -alF'" >>~/.bashrc

# setup yay
git clone https://aur.archlinux.org/yay.git /tmp/yay
(
  cd /tmp/yay
  makepkg -si --noconfirm
)
rm -rf /tmp/yay

./setup-nvim.sh
./setup-go.sh
./setup-snapper.sh
./setup-ufw.sh

# setup lemonade
go install github.com/lemonade-command/lemonade@latest

# setup etckeeper
sudo etckeeper init
sudo sed -i 's/^#* *AVOID_DAILY_AUTOCOMMITS=.*/AVOID_DAILY_AUTOCOMMITS=1/' /etc/etckeeper/etckeeper.conf
sudo systemctl mask --now etckeeper.timer

# disable faillock
grep -q '^deny =' /etc/security/faillock.conf &&
  sudo sed -i 's/^deny =.*/deny = 0/' /etc/security/faillock.conf ||
  echo "deny = 0" | sudo tee -a /etc/security/faillock.conf

echo ""
echo "Finished. Please reboot."
