#!/bin/bash
status=$(</var/dashboard/statuses/fastsync)

if [[ $status == 'true' ]]
then
  wget -o https://pisces-snap.sidcloud.cn/snap/snap-update.sh | bash
  pid=$!
  echo $pid > /var/dashboard/statuses/fastsync
else
  if [[ $status != 'false' ]]
  then
    if ps -p $status > /dev/null
    then
      echo $status > /var/dashboard/statuses/fastsync
    else
      echo 'false' > /var/dashboard/statuses/fastsync
    fi
  fi
fi
