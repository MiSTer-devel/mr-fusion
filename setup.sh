#!/bin/bash
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

BUILDROOT_VERSION="2020.02.3"

# Install dependencies
## System packages
sudo apt-get -y install build-essential git libncurses-dev flex bison openssl \
  libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf \
  liblz4-tool bc curl gcc git libssl-dev libncurses5-dev lzop make \
  unzip exfat-utils rsync dosfstools fdisk

pushd build
## Linux kernel
if [ ! -d linux-socfpga ]
  then
    git clone --depth 1 --recurse-submodules --shallow-submodules \
    https://github.com/michaelshmitty/linux-socfpga.git
fi

## Buildroot
if [ ! -d buildroot ]
  then
    wget --quiet -c https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz
    tar xf buildroot-${BUILDROOT_VERSION}.tar.gz
    mv buildroot-${BUILDROOT_VERSION} buildroot
    rm buildroot-${BUILDROOT_VERSION}.tar.gz
fi
popd

# Copy configuration files
## Buildroot configuration
cp config/buildroot-defconfig build/buildroot/configs/mrfusion_defconfig
## Kernel configuration
cp config/kernel-defconfig build/linux-socfpga/arch/arm/configs/mrfusion_defconfig
## MiSTer installation init script
mkdir -p build/buildroot/board/mrfusion/rootfs-overlay/etc/init.d
cp scripts/S99install-MiSTer.sh build/buildroot/board/mrfusion/rootfs-overlay/etc/init.d/
