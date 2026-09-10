#!/bin/bash
set -euo pipefail

sudo pacman -S --needed --noconfirm snap-pac
sudo snapper -c root set-config \
  TIMELINE_CREATE="yes" \
  TIMELINE_CLEANUP="yes" \
  TIMELINE_LIMIT_HOURLY="2" \
  TIMELINE_LIMIT_DAILY="2" \
  TIMELINE_LIMIT_WEEKLY="2" \
  TIMELINE_LIMIT_MONTHLY="0" \
  TIMELINE_LIMIT_YEARLY="0" \
  NUMBER_CLEANUP="yes" \
  NUMBER_LIMIT="5" \
  NUMBER_LIMIT_IMPORTANT="5"
