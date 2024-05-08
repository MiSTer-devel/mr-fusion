# Copyright 2024 Michael Smith <m@hacktheplanet.be>

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

FROM debian:bookworm
ARG BUILDROOT_VERSION=2024.02.1
ARG MAKE_JOBS=10

RUN apt-get -y update && apt-get -y install build-essential git curl file wget cpio unzip rsync bc flex bison zip \
  fdisk dosfstools
RUN useradd -m -d /home/mr-fusion -s /bin/bash mr-fusion
USER mr-fusion

WORKDIR /home/mr-fusion
RUN git clone -q --depth 1 --recurse-submodules --shallow-submodules \
    https://github.com/michaelshmitty/linux-socfpga.git && \
    curl -LsS "https://buildroot.org/downloads/buildroot-${BUILDROOT_VERSION}.tar.gz" | tar -xz && \
    mv buildroot-${BUILDROOT_VERSION} buildroot
COPY ./builder/config/buildroot-defconfig ./buildroot/configs/mr-fusion_defconfig
COPY ./builder/config/kernel-defconfig ./linux-socfpga/arch/arm/configs/mr-fusion_defconfig
COPY ./builder/scripts/S99install-MiSTer.sh ./buildroot/board/mr-fusion/rootfs-overlay/etc/init.d/

WORKDIR /home/mr-fusion/buildroot
RUN make mr-fusion_defconfig && make

WORKDIR /home/mr-fusion/linux-socfpga
RUN make ARCH=arm CROSS_COMPILE=../buildroot/output/host/bin/arm-buildroot-linux-gnueabi- mr-fusion_defconfig && \
  make ARCH=arm CROSS_COMPILE=../buildroot/output/host/bin/arm-buildroot-linux-gnueabi- -j $MAKE_JOBS && \
  make ARCH=arm CROSS_COMPILE=../buildroot/output/host/bin/arm-buildroot-linux-gnueabi- socfpga_cyclone5_socdk.dtb

USER root
COPY ./builder/scripts/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
WORKDIR /home/mr-fusion
ENTRYPOINT ["/entrypoint.sh"]
