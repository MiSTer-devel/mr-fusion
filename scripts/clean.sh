#!/bin/bash

# buildroot
cd ~/buildroot
make clean

# u-boot
cd ~/u-boot
make clean

# kernel
cd ~/linux-socfpga
make clean

# images
rm /vagrant/images/*
