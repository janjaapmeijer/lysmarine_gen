#!/bin/bash -e

if [ "$BBN_KIND" == "LITE" ] ; then
  exit 0
fi

apt-get clean

apt-get -y -q install vlc cheese vokoscreen # totem

