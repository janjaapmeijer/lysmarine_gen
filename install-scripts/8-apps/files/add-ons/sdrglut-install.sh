#!/bin/bash -e

# See: https://github.com/righthalfplane/SdrGlut

myArch=$(dpkg --print-architecture)

sudo apt-get -y install build-essential libsoapysdr0.7 libsoapysdr-dev libopenal-dev \
 libliquid-dev freeglut3 freeglut3-dev libalut0 libalut-dev librtaudio-dev libsndfile1-dev
sudo apt-get -y install git
cd /home/user
rm -rf SdrGlut || true
git clone -b v1.31 https://github.com/righthalfplane/SdrGlut
cd SdrGlut
sed -i -e 's~#define WINDOWS_LONG_NAMES~//#define WINDOWS_LONG_NAMES~g'  MainSource/firstFile.h
make -f makefileRaspbian -j 4

# to run
# ./sdrglut.x
