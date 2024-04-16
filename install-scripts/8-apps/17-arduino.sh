#!/bin/bash -e

#apt-get install -y gcc-avr avr-libc arduino-core-avr # avrdude

pushd /opt
  ARD_URL=https://downloads.arduino.cc
  ARD_FILE=arduino-1.8.19-linuxarm.tar.xz
  if [ "$LMARCH" == 'arm64' ]; then
    ARD_FILE=arduino-1.8.19-linuxaarch64.tar.xz
  fi
  wget $ARD_URL/$ARD_FILE
  xzcat $ARD_FILE | tar xvf -
  rm $ARD_FILE
  pushd arduino-1.8.19
    install -d /root/.config
    ./install.sh
    ./arduino-linux-setup.sh root
  popd
popd

