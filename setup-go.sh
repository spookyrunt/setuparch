#!/bin/bash
set -euo pipefail

GO_VERSION="$(curl -fsSL 'https://go.dev/dl/?mode=json' | jq -r '.[0].version')"
GO_FILE="${GO_VERSION}.linux-amd64.tar.gz"
curl -fLO "https://go.dev/dl/${GO_FILE}"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "$GO_FILE"
rm -f "$GO_FILE"

# export go bin
if ! grep -q 'export PATH="$PATH:$HOME/go/bin"' ~/.bash_profile 2>/dev/null; then
  printf '\nexport PATH="$PATH:$HOME/go/bin"' >>~/.bash_profile
fi
if ! grep -q 'export PATH="$PATH:/usr/local/go/bin"' ~/.bash_profile 2>/dev/null; then
  printf '\nexport PATH="$PATH:/usr/local/go/bin"' >>~/.bash_profile
fi

echo "Installed: ${GO_VERSION}"
