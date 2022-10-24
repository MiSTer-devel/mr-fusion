# -*- mode: ruby -*-
# vi: set ft=ruby :
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

VM_MEMORY=4096
VM_CORES=2
VM_DISK_SIZE=50
BUILDROOT_VERSION="2020.02.3"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://vagrantcloud.com/search.
  config.vm.box = "ubuntu/bionic64"
  config.disksize.size = "#{VM_DISK_SIZE}GB"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # NOTE: This will enable public access to the opened port
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine and only allow access
  # via 127.0.0.1 to disable public access
  # config.vm.network "forwarded_port", guest: 80, host: 8080, host_ip: "127.0.0.1"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end

  config.vm.provider :virtualbox do |v, override|
    v.memory = VM_MEMORY
    v.cpus = VM_CORES

    required_plugins = %w( vagrant-vbguest )
    required_plugins.each do |plugin|
      system "vagrant plugin install #{plugin}" unless Vagrant.has_plugin? plugin
    end
  end

  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  config.vm.provision 'shell' do |s|
    s.inline = 'echo Setting up machine name'

    config.vm.provider :virtualbox do |v, override|
      v.name = "Mr. Fusion build environment"
    end
  end

  # Update, upgrade and install required system packages
  config.vm.provision "shell", inline: <<-SHELL
    apt-get -y update
    apt-get -y upgrade
    apt-get -y install build-essential git libncurses-dev flex bison openssl \
      libssl-dev dkms libelf-dev libudev-dev libpci-dev libiberty-dev autoconf \
      liblz4-tool bc curl gcc git libssl-dev libncurses5-dev lzop make \
      unzip exfat-utils
    apt-get -y build-dep linux
    apt-get -q -y autoremove
    apt-get -q -y clean
  SHELL

  # Download Linux kernel source and Buildroot
  config.vm.provision "shell", privileged: false, inline: <<-SHELL
    if [ ! -d /home/vagrant/linux-socfpga ]
      then
        git clone --depth 1 --recurse-submodules --shallow-submodules https://github.com/michaelshmitty/linux-socfpga.git
    fi

    if [ ! -d /home/vagrant/buildroot ]
      then
        wget --quiet -c https://buildroot.org/downloads/buildroot-#{BUILDROOT_VERSION}.tar.gz
        tar xf buildroot-#{BUILDROOT_VERSION}.tar.gz
        mv buildroot-#{BUILDROOT_VERSION} buildroot
        rm buildroot-#{BUILDROOT_VERSION}.tar.gz
    fi
  SHELL

  # Copy Kconfig configuration files
  ## buildroot configuration
  config.vm.provision "file", source: "config/buildroot-defconfig",
                              destination: "/home/vagrant/buildroot/configs/mrfusion_defconfig"

  ## kernel configuration
  config.vm.provision "file", source: "config/kernel-defconfig",
                              destination: "/home/vagrant/linux-socfpga/arch/arm/configs/mrfusion_defconfig"

  # Copy MiSTer installation init script
  config.vm.provision "file", source: "scripts/S99install-MiSTer.sh",
                              destination: "/home/vagrant/buildroot/board/mrfusion/rootfs-overlay/etc/init.d/"
end
