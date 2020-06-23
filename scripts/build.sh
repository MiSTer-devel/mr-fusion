#!/bin/bash

# buildroot
cd ~/buildroot
make mrfusion_defconfig
make

# u-boot
cd ~/u-boot
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- mrfusion_defconfig
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- -j10

# Linux
cd ~/linux-socfpga
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- mrfusion_defconfig
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- -j10
make ARCH=arm CROSS_COMPILE=~/buildroot/output/host/bin/arm-buildroot-linux-uclibcgnueabi- socfpga_cyclone5_socdk.dtb
