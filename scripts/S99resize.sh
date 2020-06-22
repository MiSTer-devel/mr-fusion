#!/bin/sh

# This script is used as an init script and should only
# run on startup, not on shutdown.
if [ ! "$1" = "start" ]; then
  exit 0
fi

# Backup the MiSTer release files to memory.
mkdir -p /mnt/release /tmp/release
mount -r /dev/mmcblk0p2 /mnt/release
cd /tmp/release
unrar x /mnt/release/release.rar
umount /mnt/release

# Re-partition the SD card:
# 1. Create an ExFAT partition spanning almost the entire SD card.
# 2. Create a small 0xA2 type partition at the end to store the bootloader.
DATA_PARTITION_SIZE=$(($( cat /sys/block/mmcblk0/size ) - 8192))
sfdisk --force /dev/mmcblk0 << EOF
; ${DATA_PARTITION_SIZE}; 07
; ; a2
EOF

# Create the MiSTer_Data partition.
mkfs.exfat -n "MiSTer_Data" /dev/mmcblk0p1

# Mount the MiSTer_Data partition.
mkdir -p /mnt/data
mount.exfat-fuse /dev/mmcblk0p1 /mnt/data

# Copy the MiSTer release files to the MiSTer_Data partition.
cp -r /tmp/release/files/* /mnt/data/
umount /mnt/data

# Write the MiSTer bootloader.
dd if="/tmp/release/files/linux/uboot.img" of="/dev/mmcblk0p2" bs=64k
sync

reboot
