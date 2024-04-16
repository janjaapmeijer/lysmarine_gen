#!/bin/bash -e

mkdir -p /var/log/chrony

apt-get install -y -q chrony
systemctl disable systemd-timesyncd

## TimeZone
ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
