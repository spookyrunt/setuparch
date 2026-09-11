#!/bin/bash
set -euo pipefail

sudo pacman -S --needed --noconfirm snap-pac
sudo snapper -c root set-config \
  TIMELINE_CREATE="yes" \
  TIMELINE_CLEANUP="yes" \
  TIMELINE_LIMIT_HOURLY="1" \
  TIMELINE_LIMIT_DAILY="1" \
  TIMELINE_LIMIT_WEEKLY="1" \
  TIMELINE_LIMIT_MONTHLY="1" \
  TIMELINE_LIMIT_YEARLY="0" \
  NUMBER_CLEANUP="yes" \
  NUMBER_LIMIT="4" \
  NUMBER_LIMIT_IMPORTANT="4"
sudo snapper -c home set-config \
  TIMELINE_CREATE="yes" \
  TIMELINE_CLEANUP="yes" \
  TIMELINE_LIMIT_HOURLY="1" \
  TIMELINE_LIMIT_DAILY="1" \
  TIMELINE_LIMIT_WEEKLY="1" \
  TIMELINE_LIMIT_MONTHLY="1" \
  TIMELINE_LIMIT_YEARLY="0" \
  NUMBER_CLEANUP="yes" \
  NUMBER_LIMIT="4" \
  NUMBER_LIMIT_IMPORTANT="4"
sudo snapper -v -c root cleanup all
sudo snapper -v -c home cleanup all
