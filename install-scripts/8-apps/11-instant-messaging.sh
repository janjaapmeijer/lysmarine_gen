#!/bin/bash -e

apt-get -y -q install empathy libayatana-appindicator3-1

apt-get clean

# FB messenger
if [ "$LMARCH" == 'armhf' ]; then
  arch=armv7l
elif [ "$LMARCH" == 'arm64' ]; then
  arch=arm64
elif [ "$LMARCH" == 'amd64' ]; then
  arch=x64
else
  arch=$LMARCH
fi

#wget http://ftp.us.debian.org/debian/pool/main/libi/libindicator/libindicator3-7_0.5.0-4_${arch}.deb
#wget http://ftp.us.debian.org/debian/pool/main/liba/libappindicator/libappindicator3-1_0.4.92-7_${arch}.deb
#dpkg -i libindicator3-7_0.5.0-4_${arch}.deb libappindicator3-1_0.4.92-7_${arch}.deb
#rm libindicator3-7_0.5.0-4_${arch}.deb libappindicator3-1_0.4.92-7_${arch}.deb

wget https://github.com/mquevill/caprine/releases/download/v2.54.1-ARM/caprine_2.54.1_"${arch}".deb
#dpkg -i caprine_2.54.1_"${arch}".deb
dpkg-deb -xv caprine_2.54.1_"${arch}".deb /
chown root:root /
chmod 755 /
rm caprine_2.54.1_"${arch}".deb
