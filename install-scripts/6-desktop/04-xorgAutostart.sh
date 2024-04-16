#!/bin/bash -e

install -v -m644 "$FILE_FOLDER"/startx.service "/etc/systemd/system/startx.service"

systemctl enable startx.service
systemctl set-default graphical.target


#ln -s /usr/lib/aarch64-linux-gnu/dri /usr/lib/dri

