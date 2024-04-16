#!/bin/bash -e

if [ "$BBN_KIND" == "LITE" ] ; then
  exit 0
fi

install -v -o 1000 -g 1000 -m 0755 "$FILE_FOLDER"/add-ons/anbox-android-img-install.sh "/home/user/add-ons/"
