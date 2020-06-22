Source: http://blog.reds.ch/?p=675

# u-boot

## Load default config

`make ARCH=arm CROSS_COMPILE=~/buildroot-2020.02.3/output/host/bin/arm-buildroot-linux-uclibcgnueabi- socfpga_de10_nano_defconfig`

## Menu config

`make ARCH=arm CROSS_COMPILE=~/buildroot-2020.02.3/output/host/bin/arm-buildroot-linux-uclibcgnueabi- menuconfig`

## Build

`make ARCH=arm CROSS_COMPILE=~/buildroot-2020.02.3/output/host/bin/arm-buildroot-linux-uclibcgnueabi- -j10`

# Kernel

## Load default config

`make ARCH=arm CROSS_COMPILE=~/buildroot-2020.02.3/output/host/bin/arm-buildroot-linux-uclibcgnueabi- socfpga_defconfig`

## Menu config

`make ARCH=arm CROSS_COMPILE=~/buildroot-2020.02.3/output/host/bin/arm-buildroot-linux-uclibcgnueabi- menuconfig`

## Build

`make ARCH=arm CROSS_COMPILE=~/buildroot-2020.02.3/output/host/bin/arm-buildroot-linux-uclibcgnueabi- -j10`

## Generate device tree

`make ARCH=arm CROSS_COMPILE=~/buildroot-2020.02.3/output/host/bin/arm-buildroot-linux-uclibcgnueabi- socfpga_cyclone5_socdk.dtb`
