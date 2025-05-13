#!/bin/bash
# Copyright 2024 Michael Smith <m@hacktheplanet.be>

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

if [[ -z "${MISTER_RELEASE}" ]]; then
  echo "Please set MISTER_RELEASE environment variable to a valid release, e.g. 'release_20231108.7z'"
  echo "See https://github.com/MiSTer-devel/SD-Installer-Win64_MiSTer/tree/master for a list of available releases."
  exit 1
fi

echo "Building SD card image with ${MISTER_RELEASE}..."

# Create the SD card image container
dd if=/dev/zero of=/files/images/mr-fusion.img bs=12M count=10

# Partition the SD card image
sfdisk --force /files/images/mr-fusion.img << EOF
start=10240, type=0b
start=2048, size=8192, type=a2
EOF

# Attach the SD card image to a loopback device
losetup -fP /files/images/mr-fusion.img

# Install the bootloader
dd if="/files/vendor/bootloader.img" of="/dev/loop0p2" bs=64k
sync

# Create the data partition
mkfs.vfat -n "MRFUSION" /dev/loop0p1
mkdir -p /mnt/data
mount /dev/loop0p1 /mnt/data

# Copy support files
cp -r /files/vendor/support/* /mnt/data/

# Copy kernel and initramfs
cp /home/mr-fusion/linux-socfpga/arch/arm/boot/zImage /mnt/data

# Download and copy MiSTer release.
curl -LsS -o /mnt/data/release.7z \
  https://github.com/MiSTer-devel/SD-Installer-Win64_MiSTer/raw/master/${MISTER_RELEASE}

# Support MiSTer Scripts
mkdir -p /mnt/data/Scripts

# Bundle WiFi setup script with Mr. Fusion
curl -LsS -o /mnt/data/Scripts/wifi.sh \
  https://raw.githubusercontent.com/MiSTer-devel/Scripts_MiSTer/master/other_authors/wifi.sh

# Bundle SDL Game Controller database with Mr. Fusion
curl -LsS -o /mnt/data/gamecontrollerdb.txt \
  https://raw.githubusercontent.com/MiSTer-devel/Distribution_MiSTer/main/linux/gamecontrollerdb/gamecontrollerdb.txt

# Bundle update_all script with Mr. Fusion
curl -LsS -o /mnt/data/Scripts/update_all.sh \
  https://raw.githubusercontent.com/theypsilon/Update_All_MiSTer/master/update_all.sh

# Support custom MiSTer config
mkdir -p /mnt/data/config

# Clean up
sync
umount /mnt/data
losetup -d /dev/loop0

# Rename and compress the SD card image
cd /files/images
zip -m mr-fusion-$(date +"%Y-%m-%d").img.zip mr-fusion.img
