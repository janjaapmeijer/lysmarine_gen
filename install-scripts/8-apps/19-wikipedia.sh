#!/bin/bash -e

apt-get -y install libqt5webenginecore5 libqt5webenginewidgets5 zim-tools

if [ "$LMARCH" == 'arm64' ]; then
  wget https://github.com/bareboat-necessities/lysmarine_gen/releases/download/vTest/kiwix_2.2.0.0_arm64.deb
  dpkg -i kiwix_*.deb
  rm kiwix_*.deb
fi
