#!/bin/bash -e

if [ "$LMARCH" == 'armhf' ]; then
  apt-get -y install openjdk-11-jdk openjdk-11-jdk-headless openjdk-11-jre openjdk-11-jre-headless

  apt-get -y remove --purge openjdk-8-jdk openjdk-8-jdk-headless openjdk-8-jre openjdk-8-jre-headless
fi


if [ "$LMARCH" == 'arm64' ]; then
  apt-get -y install openjdk-17-jdk openjdk-17-jdk-headless openjdk-17-jre openjdk-17-jre-headless

  apt-get -y remove --purge openjdk-11-jdk openjdk-11-jdk-headless openjdk-11-jre openjdk-11-jre-headless
fi
