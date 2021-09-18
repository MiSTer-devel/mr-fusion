#!/bin/bash
# Copyright 2021 Michael Smith <m@hacktheplanet.be>

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

# Create the sd card image container.
dd if=/dev/zero of=/vagrant/images/mr-fusion.img bs=12M count=10

# Partition the sd card image.
sfdisk --force /vagrant/images/mr-fusion.img << EOF
8192; 241664; 0B
2048; 8192; a2
EOF

# Attach the sd card image to a loopback device.
sudo losetup -fP /vagrant/images/mr-fusion.img

# Install the bootloader.
sudo dd if="/vagrant/vendor/bootloader.img" of="/dev/loop0p2" bs=64k
sync

# Create the data partition.
sudo mkfs.vfat -n "MRFUSION" /dev/loop0p1
sudo mkdir -p /mnt/data
sudo mount /dev/loop0p1 /mnt/data

# Copy support files.
sudo cp -r /vagrant/vendor/support/* /mnt/data/

# Copy kernel and initramfs.
sudo cp /home/vagrant/linux-socfpga/arch/arm/boot/zImage /mnt/data

# Download and copy MiSTer release.
wget -c https://github.com/MiSTer-devel/SD-Installer-Win64_MiSTer/raw/master/release_20210917.7z -O release.7z
sudo cp release.7z /mnt/data

# Support MiSTer Scripts.
sudo mkdir -p /mnt/data/Scripts
wget -c https://raw.githubusercontent.com/MiSTer-devel/Scripts_MiSTer/master/other_authors/wifi.sh
sudo cp wifi.sh /mnt/data/Scripts

# Support custom MiSTer config
sudo mkdir -p /mnt/data/config

# Clean up.
sudo umount /mnt/data
sudo losetup -d /dev/loop0
