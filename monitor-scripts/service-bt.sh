#!/bin/bash
status=$(</var/dashboard/services/BT)

if [[ $status == 'stop' ]]; then
  sudo /home/pi/config/_build/prod/rel/gateway_config/bin/gateway_config advertise off
  echo 'stopping' > /var/dashboard/services/BT
fi

if [[ $status == 'start' ]]; then
  sudo /home/pi/config/_build/prod/rel/gateway_config/bin/gateway_config advertise on
  echo 'starting' > /var/dashboard/services/BT
fi

if [[ $status == 'starting' ]]; then
  advertise_status=$(sudo /home/pi/config/_build/prod/rel/gateway_config/bin/gateway_config advertise status)
  if [[ $advertise_status == on ]]; then
    echo 'running' > /var/dashboard/services/BT
  fi
fi

if [[ $status == 'stopping' ]]; then
  advertise_status=$(sudo /home/pi/config/_build/prod/rel/gateway_config/bin/gateway_config advertise status)
  if [[ $advertise_status == off ]]; then
    echo 'disabled' > /var/dashboard/services/BT
  fi
fi
