#!/bin/bash -e

sudo bash -c 'cat << EOF > /usr/local/share/applications/noaa-enc-online.desktop
[Desktop Entry]
Type=Application
Name=NOAA ENC Online
GenericName=NOAA ENC Online
Comment=NOAA ENC Online
Exec=gnome-www-browser https://nauticalcharts.noaa.gov/enconline/enconline.html
Terminal=false
Icon=gnome-globe
Categories=WWW;Internet
EOF'
