#!/bin/bash

if [ -L /dev/twofingtouch ]; then
  if [ ! -f /usr/share/X11/xorg.conf.d/90-touchinput.conf ]; then
    MATCH_PRODUCT=$(udevadm info -a -n /dev/twofingtouch | grep "ATTRS{name}" | sed -e 's#.*=="##' -e 's#"$##')
    bash -c 'mkdir -p /usr/share/X11/xorg.conf.d; cat << EOF > /usr/share/X11/xorg.conf.d/90-touchinput.conf
Section "InputClass"
    Identifier "calibration"
    Driver "evdev"
    MatchProduct "'"${MATCH_PRODUCT}"'"
    MatchDevicePath "/dev/input/event*"
    Option "EmulateThirdButton" "1"
    Option "EmulateThirdButtonTimeout" "750"
    Option "EmulateThirdButtonMoveThreshold" "30"
EndSection
EOF'
  fi
fi
