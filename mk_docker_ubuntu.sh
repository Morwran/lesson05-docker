#!/bin/bash

# PKG_STORAGE="file:///storage/local/apt-mirror/mirror/deb.debian.org/debian"
# PKG_STORAGE="https://mirror.leaseweb.com/ubuntu/"
PKG_STORAGE="http://ru.archive.ubuntu.com/ubuntu/"
PKG_DIST=focal
PKG_ADD="net-tools,gcc,make,perl,g++,cmake,libxtables-dev,libnetfilter-conntrack-dev,iptables"

CNT_STORAGE_PWD=./base_img
CNT_NAME=$1

if [ -z "$CNT_NAME" ] ; then
          echo "Specify container name"
          exit 1
fi

CNT_STORAGE=$CNT_STORAGE_PWD/$CNT_NAME/rootfs

if [ ! -d "$CNT_STORAGE" ]; then \
    mkdir -p $CNT_STORAGE; \
fi

# ACCESS=$(id -u)

if [[ $EUID -ne 0 ]]; then
    echo "This script must be run as root"
    exit 1
fi

debootstrap --include="$PKG_ADD" $PKG_DIST $CNT_STORAGE $PKG_STORAGE || exit 1;
# chroot $CNT_STORAGE
tar -C $CNT_STORAGE -c . | docker import - $CNT_NAME:base
