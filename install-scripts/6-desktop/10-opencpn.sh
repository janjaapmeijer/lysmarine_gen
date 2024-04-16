#!/bin/bash -e

#apt-get install -y -q -o Dpkg::Options::="--force-overwrite" opencpn-sglock-arm32

#apt-get install -y -q opencpn opencpn-plugin-celestial opencpn-plugin-launcher opencpn-plugin-radar \
#   opencpn-plugin-pypilot opencpn-plugin-objsearch opencpn-plugin-iacfleet imgkap

apt-get install -y -q libglew2.1 opencpn=5.6.2+dfsg-1~bpo11+3 opencpn-data=5.6.2+dfsg-1~bpo11+3 gettext libwxsvg3 

install -o 1000 -g 1000 -d "/home/user/.opencpn"
install -o 1000 -g 1000 -d "/home/user/.opencpn/plugins"
install -o 1000 -g 1000 -d "/home/user/.opencpn/plugins/weather_routing"
install -o 1000 -g 1000 -d "/home/user/.opencpn/plugins/weather_routing/data"
install -o 1000 -g 1000 -v "$FILE_FOLDER"/opencpn.conf "/home/user/.opencpn/"
install -o 1000 -g 1000 -v "$FILE_FOLDER"/opencpn.conf "/home/user/.opencpn/opencpn.conf-bbn"
install -o 1000 -g 1000 -v "$FILE_FOLDER"/opencpn.conf-highres-bbn "/home/user/.opencpn/opencpn.conf-highres-bbn"

if [ "$LMARCH" == 'armhf' ]; then
  apt-get install -y -q                                         \
    opencpn-doc                                                 \
    opencpn-plugin-calculator                                   \
    opencpn-plugin-celestial                                    \
    opencpn-plugin-chartscale                                   \
    opencpn-plugin-climatology                                  \
    opencpn-plugin-climatology-data                             \
    opencpn-plugin-iacfleet                                     \
    opencpn-plugin-launcher                                     \
    opencpn-plugin-nmeaconverter                                \
    opencpn-plugin-objsearch                                    \
    opencpn-plugin-ocpndebugger                                 \
    opencpn-plugin-plots                                        \
    opencpn-plugin-pypilot                                      \
    opencpn-plugin-radar                                        \
    opencpn-plugin-s63                                          \
    opencpn-plugin-sar                                          \
    opencpn-plugin-tactics                                      \
    opencpn-plugin-vfkaps                                       \
    opencpn-plugin-watchdog                                     \
    opencpn-plugin-weatherfax                                   \
    opencpn-plugin-weatherrouting                               \
    opencpn-plugin-draw
fi

# Polar Diagrams

BK_DIR="$(pwd)"

mkdir /home/user/Polars && cd /home/user/Polars

wget https://www.seapilot.com/wp-content/uploads/2018/05/All_polar_files.zip
unzip All_polar_files.zip
chown user:user ./*
chmod 664 ./*
rm All_polar_files.zip

cd "$BK_DIR"


#wget https://launchpad.net/~opencpn/+archive/ubuntu/opencpn/+files/opencpn-doc_4.8.2.0-0~bionic1_all.deb
#dpkg -i opencpn-doc_4.8.2.0-0~bionic1_all.deb
#rm opencpn-doc_4.8.2.0-0~bionic1_all.deb

mkdir tmp-o-bundle-"$LMARCH" || exit 2
cd tmp-o-bundle-"$LMARCH"

wget -O opencpn-plugins-bundle-"$LMARCH".tar.gz https://github.com/bareboat-necessities/lysmarine_gen/releases/download/vTest/opencpn-plugins-bundle-o_5_8_x-bullseye-"$LMARCH".tar.gz
gzip -cd opencpn-plugins-bundle-"$LMARCH".tar.gz | tar xvf -

mkdir -p /home/user/.local/lib /home/user/.local/bin /home/user/.local/share /home/user/.local/doc /home/user/.local/include
cp -r -p lib/* /home/user/.local/lib/
cp -r -p bin/* /home/user/.local/bin/
cp -r -p share/* /home/user/.local/share/
cp -r -p doc/* /home/user/.local/doc/
cp -r -p include/* /home/user/.local/include/

chown -R user:user /home/user/.local

cd ..
rm -rf tmp-o-bundle-"$LMARCH"

if [ -f /home/user/.local/lib/opencpn/libPolar_pi.so ]; then
  mv /home/user/.local/lib/opencpn/libPolar_pi.so /usr/lib/opencpn/libpolar_pi.so
fi

if [ -f /home/user/.local/lib/opencpn/liblogbookkonni_pi.so ]; then
  rm -f /home/user/.local/lib/opencpn/libLogbookKonni_pi.so
fi

mv /home/user/.local/share/opencpn/plugins/tactics_pi/data/Tactics.svg /home/user/.local/share/opencpn/plugins/tactics_pi/data/tactics.svg
mv /home/user/.local/share/opencpn/plugins/tactics_pi/data/Tactics_rollover.svg /home/user/.local/share/opencpn/plugins/tactics_pi/data/tactics_rollover.svg
mv /home/user/.local/share/opencpn/plugins/tactics_pi/data/Tactics_toggled.svg /home/user/.local/share/opencpn/plugins/tactics_pi/data/tactics_toggled.svg
#mv /home/user/.local/share/opencpn/plugins/CanadianTides_pi/data/canadiantides_panel_icon.png /home/user/.local/share/opencpn/plugins/CanadianTides_pi/data/CanadianTides_panel_icon.png

wget https://download.tuxfamily.org/xinutop/rastow/rastow-0.4.tgz
gzip -cd rastow-0.4.tgz | tar xvf -
mv rastow.sh /usr/local/bin
rm rastow-0.4.tgz
wget https://download.tuxfamily.org/xinutop/rastow/readme.txt
mkdir /usr/local/share/rastow
mv readme.txt /usr/local/share/rastow/


#install -v "$FILE_FOLDER"/opencpn.desktop "/usr/share/applications/"


# TODO: temp fix
wget https://github.com/bareboat-necessities/lysmarine_gen/releases/download/vTest/opencpn_5.8.4+8089+1637c28fb.ubuntu20.04.1_arm64.deb
dpkg -i opencpn_5.8.4+8089+1637c28fb.ubuntu20.04.1_arm64.deb
rm opencpn_5.8*_arm64.deb
rm /etc/apt/sources.list.d/opencpn.list

# ImgKap https://github.com/nohal
apt-get -y install libfreeimage-dev
git clone --depth=1 https://github.com/nohal/imgkap
cd imgkap
make -j 4
make install
cd ..
rm -rf imgkap

# for OpenCPN
#ln -s /usr/share/opencpn/tcdata/harmonics-dwf-20220109/harmonics-dwf-20220109-free.tcd /usr/share/opencpn/tcdata/harmonics-dwf-20210110-free.tcd
