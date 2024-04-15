#!/bin/bash -e

if [ "$BBN_KIND" == "LITE" ] ; then
  exit 0
fi

apt-get install -y liblzma5 libicu72 libzstd1 libxapian30 libcurl3-gnutls libpugixml1v5aria2 libkiwix11 kiwix-tools
