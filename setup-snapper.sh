#!/bin/bash
set -euo pipefail

# set noatime,compress=zstd in /etc/fstab
sudo cp /etc/fstab "/etc/fstab.bak.$(date +%Y%m%d%H%M%S)"
awk 'BEGIN { OFS = "\t" }
     $3 == "btrfs" && !/^#/ {
         gsub(/(^|,)noatime/, "", $4)
         gsub(/(^|,)compress(-force)?=[^,]*/, "", $4)
         gsub(/,,+/, ",", $4)
         sub(/^,/, "", $4)
         $4 = $4 ",noatime,compress=zstd"
     }
     1' /etc/fstab |
sudo tee /tmp/fstab >/dev/null
sudo mv /tmp/fstab /etc/fstab

# snapper for timeline, boot, snap-pac
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
sudo systemctl enable snapper-boot.timer
sudo systemctl enable --now snapper-timeline.timer
sudo systemctl enable --now snapper-cleanup.timer
sudo snapper -c root create -d "Initial automated setup"
sudo snapper -c home create -d "Initial automated setup"
echo ""
echo "Done. You may use btrfs-assistant or snapper-rollback for rollback instead of snapper rollback."
