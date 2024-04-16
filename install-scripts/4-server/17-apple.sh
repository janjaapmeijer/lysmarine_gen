#!/bin/bash -e

apt-get -y -q install shairport-sync usbmuxd

install -v -m 0644 "$FILE_FOLDER"/shairport-sync.conf "/etc/"

usermod -aG gpio shairport-sync

systemctl enable shairport-sync

install -m 755 -d -o usbmux -g plugdev "/var/lib/usbmux"

install -v -m 0644 "$FILE_FOLDER"/52-carplay.rules "/etc/udev/rules.d/52-carplay.rules"

apt-get clean
