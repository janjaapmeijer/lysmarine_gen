#!/bin/bash -e

apt-get install -y -q evdev-rce

echo 'uinput' | tee -a /etc/modules

install -o 1000 -g 1000 -d "/home/user/.config"
install -o 1000 -g 1000 -d "/home/user/.config/autostart"
