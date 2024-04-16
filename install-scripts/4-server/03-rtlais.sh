#!/bin/bash -e
## https://pysselilivet.blogspot.com/2018/06/ais-reciever-for-raspberry.html

# moved into 00-radio-sdr.sh
#apt-get install -y -q rtl-ais kalibrate-rtl

## Adding service file
install -v -m 0644 "$FILE_FOLDER"/rtl-ais.service "/etc/systemd/system/"
systemctl disable rtl-ais.service
