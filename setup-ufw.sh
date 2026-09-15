#!/bin/bash
set -euo pipefail

sudo chattr -i /etc/ufw/user.rules
sudo chattr -i /etc/ufw/user6.rules

sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw default deny routed
sudo ufw allow from 192.168.0.0/24
sudo ufw enable

sudo chattr +i /etc/ufw/user.rules
sudo chattr +i /etc/ufw/user6.rules
