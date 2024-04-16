#!/bin/bash
{
  chmod a+r /dev/ttyLYS_prolific_"$1"
  if [[ $2 == "remove" ]] ; then
    logger "The USB device /dev/ttyLYS_prolific_$1 has been disconnected"
  else
    logger "This USB device is known as Prolific and will be linked on /dev/ttyLYS_prolific_$1"
    /usr/local/sbin/bounce-mux
  fi
}&
