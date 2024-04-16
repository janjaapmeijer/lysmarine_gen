#!/bin/bash
{
  chmod a+r /dev/ttyLYS_gps_"$1"
  if [[ $2 == "remove" ]] ; then
    logger "The USB device /dev/ttyLYS_gps_$1 has been disconnected"
    if [[ $1 == "0" ]] ; then
      gpsdctl remove /dev/ttyLYS_gps_0
    else
      systemctl stop lysgpsd@"$1".service
    fi
  else
    if [[ $1 == "0" ]] ; then
      logger "This USB device is known as GPS and will be connected to gpsd on port 2947 /dev/ttyLYS_gps_$1"
      systemctl restart gpsd
      export GPSD_OPTIONS="-p"
      gpsdctl add /dev/ttyLYS_gps_0
    else
      logger "This USB device is known as GPS and will be connected to gpsd on port 2947$1 /dev/ttyLYS_gps_$1"
      systemctl restart lysgpsd@"$1".service
      sleep 1
      systemctl is-enabled signalk && systemctl restart signalk
    fi
  fi
}&
