#!/bin/bash

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
wget -c https://github.com/MiSTer-devel/SD-Installer-Win64_MiSTer/raw/master/release_20200908.rar -O release.rar
sudo cp release.rar /mnt/data

# Support MiSTer Scripts.
sudo mkdir -p /mnt/data/Scripts
wget -c https://raw.githubusercontent.com/MiSTer-devel/Scripts_MiSTer/master/other_authors/wifi.sh
sudo cp wifi.sh /mnt/data/Scripts

# Clean up.
sudo umount /mnt/data
sudo losetup -d /dev/loop0
