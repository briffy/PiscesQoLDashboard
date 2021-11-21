#!/bin/bash
status=$(</var/dashboard/services/miner)

if [[ $status == 'stop' ]]; then
  sudo docker stop miner
  echo 'stopping' > /var/dashboard/services/miner
fi

if [[ $status == 'start' ]]; then
  sudo docker start miner
  echo 'starting' > /var/dashboard/services/miner
fi

if [[ $status == 'starting' ]]; then
  miner_status=$(sudo docker inspect --format "{{.State.Running}}" miner)
  if [[ $miner_status == true ]]; then
    echo 'running' > /var/dashboard/services/miner
  fi
fi

if [[ $status == 'stopping' ]]; then
  miner_status=$(sudo docker inspect --format "{{.State.Running}}" miner)
  if [[ $miner_status == false ]]; then
    echo 'disabled' > /var/dashboard/services/miner
  fi
fi
