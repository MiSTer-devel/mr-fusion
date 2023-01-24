#!/bin/sh
# Copyright 2022 Michael Smith <m@hacktheplanet.be>

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License version 3 as published
# by the Free Software Foundation.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.

# This script is used as an init script and should only
# run on startup, not on shutdown.
if [ ! "$1" = "start" ]; then
  exit 0
fi

# Backup the MiSTer release files to memory.
mkdir -p /mnt/release /tmp/release
mount -r /dev/mmcblk0p1 /mnt/release

## Show splash screen
fbv -fr /mnt/release/splash.png &
cd /tmp/release
7zr x /mnt/release/release.7z

## (Custom) scripts support
cp /mnt/release/Scripts/* /tmp/release/files/Scripts

## Custom wpa_supplicant.conf support
if [[ -f /mnt/release/wpa_supplicant.conf ]]; then
  cp /mnt/release/wpa_supplicant.conf /tmp/release/files/linux
fi

## Custom samba.sh support
if [[ -f /mnt/release/samba.sh ]]; then
  cp /mnt/release/samba.sh /tmp/release/files/linux
fi

## Custom config support
cp -r /mnt/release/config /tmp/release/files/

## SDL Game Controller DB support
mkdir -p /tmp/release/files/linux/gamecontrollerdb
cp -r /mnt/release/gamecontrollerdb.txt /tmp/release/files/linux/gamecontrollerdb/

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
