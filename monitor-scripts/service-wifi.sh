#!/bin/bash
status=$(</var/dashboard/services/wifi)

if [[ $status == 'stop' ]]; then
  ip link set wlan0 down
  echo 'disabled' > /var/dashboard/services/wifi
  sleep 5
  bash /etc/monitor-scripts/local-ip.sh
fi

if [[ $status == 'start' ]]; then
  ip link set wlan0 up
  echo 'starting' > /var/dashboard/services/wifi
fi

if [[ $status == 'starting' ]]; then
  service=$(</var/dashboard/statuses/wifi)
  if [[ $service ]]; then
    bash /etc/monitor-scripts/local-ip.sh
    echo 'running' > /var/dashboard/services/wifi
  fi
fi

if [[ $status == 'disabled' ]]; then
  service=$(</var/dashboard/statuses/wifi)
  if [[ $service ]]; then
    ip link set wlan0 down
  fi;
fi;
