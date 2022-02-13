#!/bin/bash
service=$(cat /var/dashboard/services/fastsync | tr -d '\n')

if [[ $service == 'start' ]]; then
  echo 'running' > /var/dashboard/services/fastsync
  snap_height=$(curl --silent https://snapshots-wtf.sensecapmx.cloud/latest-snap.json|awk -F':' '{print $3}'| rev | cut -c2- | rev)
  wget https://snapshots-wtf.sensecapmx.cloud/snap-$snap_height -O /home/pi/hnt/miner/snap/snap-$snap_height
  docker exec miner miner repair sync_pause
  docker exec miner miner repair sync_cancel
  docker exec miner miner snapshot load /var/data/snap/snap-latest
fi

if [[ $service == 'running' ]]; then
  sync_state=$(docker exec miner miner repair sync_state)
  if [[ $sync_state == 'sync active' ]]; then
    docker exec miner miner repair sync_resume
    echo 'stopped' > /var/dashboard/services/fastsync
  fi
fi
