#!/bin/bash -e

groupadd solarthing
useradd -r -g solarthing -G dialout,tty,video solarthing
usermod -a -G dialout,tty,video solarthing
usermod -a -G gpio solarthing
usermod -a -G solarthing,dialout,tty,video user

OLD_DIR=$(pwd)

cd /opt 
git clone --depth=1 --single-branch https://github.com/wildmountainfarms/solarthing.git || exit 1

cd /opt/solarthing 
/opt/solarthing/other/linux/create_user.sh 

cd /opt/solarthing
/opt/solarthing/other/linux/update_perms.sh continue || true

/opt/solarthing/program/.bin/solarthing version || true

rm -rf ./*.core ./*.log
rm -rf /opt/solarthing/.git

cd $OLD_DIR
