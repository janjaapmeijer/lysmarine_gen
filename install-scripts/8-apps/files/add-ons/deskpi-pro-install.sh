#!/bin/bash -e

# See: https://github.com/DeskPi-Team/deskpi

cd ~
git clone --depth=1 https://github.com/DeskPi-Team/deskpi.git
cd ~/deskpi/

myArch=$(dpkg --print-architecture)

if [ "arm64" != "$myArch" ] ; then
  chmod +x install.sh
  sudo ./install.sh
else
  chmod +x install-raspios-64bit.sh
  sudo ./install-raspios-64bit.sh
fi
