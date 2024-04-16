#!/bin/bash -e

if [ "$BBN_KIND" == "LITE" ] ; then
  exit 0
fi

apt-get -q -y install boats libts-bin

