#!/bin/bash

# Create the sd card image container.
dd if=/dev/zero of=/shared/mr-fusion.img bs=12M count=10

# Partition the sd card image.
sfdisk --force /shared/mr-fusion.img << EOF
; 8192; a2
; ; 0B
EOF

# Attach the sd card image to a loopback device.
sudo losetup -fP /shared/mr-fusion.img

# Install the bootloader.
sudo dd if="/home/vagrant/u-boot/u-boot-with-spl.sfp" of="/dev/loop0p1" bs=64k
sync

# Create the data partition.
sudo mkfs.vfat -n "MRFUSION" /dev/loop0p2
sudo mkdir -p /mnt/data
sudo mount /dev/loop0p2 /mnt/data

# Copy kernel and initramfs.
sudo cp /home/vagrant/linux-socfpga/arch/arm/boot/zImage /mnt/data

# Copy device tree.
sudo cp /home/vagrant/linux-socfpga/arch/arm/boot/dts/socfpga_cyclone5_socdk.dtb /mnt/data

# Download and copy MiSTer release.
wget -c https://github.com/MiSTer-devel/SD-Installer-Win64_MiSTer/raw/master/release_20200618.rar -O release.rar
sudo cp release.rar /mnt/data

# Clean up.
sudo umount /mnt/data
sudo losetup -d /dev/loop0
