#!/bin/bash

# buildroot
cd ~/buildroot
make clean

# kernel
cd ~/linux-socfpga
make clean

# images
rm /vagrant/images/*
