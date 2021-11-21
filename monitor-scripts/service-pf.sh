#!/bin/bash
status=$(</var/dashboard/services/PF)

if [[ $status == 'stop' ]]; then
  pid=$(sudo pgrep lora_pkt_+)
  sudo kill -9 $pid
  echo 'disabled' > /var/dashboard/services/PF
fi

if [[ $status == 'start' ]]; then
  cd /home/pi/hnt/paket/paket/packet_forwarder/
  ./lora_pkt_fwd >> /dev/null 2>&1
  echo 'starting' > /var/dashboard/services/PF
fi

if [[ $status == 'starting' ]]; then
  pid=$(sudo pgrep lora_pkt_+)
  if [[ $pid ]]; then
    echo 'running' > /var/dashboard/services/PF
  fi
fi
