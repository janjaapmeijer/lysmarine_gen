#!/bin/bash -e

mkdir -p /var/log/chrony

apt-get install -y -q chrony at
if service --status-all | grep -Fq 'systemd-timesyncd'; then
  systemctl disable systemd-timesyncd || true
fi

## TimeZone
ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime
dpkg-reconfigure -f noninteractive tzdata
