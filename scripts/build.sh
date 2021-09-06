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

# buildroot
cd ~/buildroot
make mrfusion_defconfig
make

# Linux
cd ~/linux-socfpga
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- mrfusion_defconfig
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- -j10
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- socfpga_cyclone5_socdk.dtb
