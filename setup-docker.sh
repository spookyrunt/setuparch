#!/bin/bash
sudo pacman -S docker docker-compose
sudo usermod -aG docker $USER

# For enabled daemon
# sudo systemctl enable --now docker.service

# For disabled daemon
sudo systemctl disable --now docker.socket
sudo systemctl disable --now docker.service
sudo systemctl start docker
