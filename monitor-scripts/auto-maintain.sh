#!/bin/bash
service=$(cat /var/dashboard/services/auto-maintain | tr -d '\n')

if [[ $service == 'enabled' ]]; then
  bash /etc/monitor-scripts/update-check.sh &> /dev/null
  bash /etc/monitor-scripts/miner-version-check.sh &> /dev/null
  bash /etc/monitor-scripts/helium-statuses.sh &> /dev/null
  miner_version=$(cat /var/dashboard/statuses/current_miner_version | tr -d '\n')
  latest_miner_version=$(cat /var/dashboard/statuses/latest_miner_version | tr -d '\n')
  dashboard_version=$(cat /var/dashboard/version | tr -d '\n')
  latest_dashboard_version=$(cat /var/dashboard/update | tr -d '\n')
  current_docker_status=$(sudo docker ps -a -f name=miner --format "{{ .Status }}")
  current_info_height=$(cat /var/dashboard/statuses/infoheight)
  live_height=$(cat /var/dashboard/statuses/current_blockheight)
  snap_height=$(wget -q https://helium-snapshots.nebra.com/latest.json -O - | grep -Po '\"height\": [0-9]*' | sed 's/\"height\": //')
  pubkey=$(cat /var/dashboard/statuses/animal_name)
  echo "Miner Version: $miner_version"
  echo "Latest Miner Version: $latest_miner_version"
  echo "Dashboard Version: $dashboard_version"
  echo "Latest Dashboard Version: $latest_dashboard_version"
  echo "Docker Status: $current_docker_status"
  echo "Current Info Height: $current_info_height"
  echo "Live height: $live_height"
  echo "Snap height: $snap_height"
  if [[ ! $current_docker_status =~ 'Up' ]]; then
    echo "[$(date)] Problems with docker, trying to start..." >> /var/dashboard/logs/auto-maintain.log
    docker start miner
    sleep 1m
    current_docker_status=$(sudo docker ps -a -f name=miner --format "{{ .Status }}")
    uptime=$(sudo docker ps -a -f name=miner --format "{{ .Status }}" | grep -Po "Up [0-9]* seconds" | sed 's/ seconds//' | sed 's/Up //')

    if [[ ! $current_docker_status =~ 'Up' ]] || [[ $uptime != '' && $uptime -le 55 ]]; then
      echo "[$(date)] Still problems with docker, trying a miner update..." >> /var/dashboard/logs/auto-maintain.log
      echo 'start' > /var/dashboard/services/miner-update
      bash /etc/monitor-scripts/miner-update.sh
      sleep 1m
      current_info_height=$(cat /var/dashboard/statuses/infoheight)
      current_docker_status=$(sudo docker ps -a -f name=miner --format "{{ .Status }}")
      uptime=$(sudo docker ps -a -f name=miner --format "{{ .Status }}" | grep -Po "Up [0-9]* seconds" | sed 's/ seconds//' | sed 's/Up //')

      if [[ ! $current_docker_status =~ 'Up' || $uptime != '' && $uptime -le 55 ]]; then
        echo "[$(date)] STILL problems with docker, trying a blockchain clear..." >> /var/dashboard/logs/auto-maintain.log
        echo 'start' > /var/dashboard/services/clear-blockchain
        bash /etc/monitor-scripts/clear-blockchain.sh
        sleep 1m
        current_info_height=$(cat /var/dashboard/statuses/infoheight)
      fi
    fi
  fi
  if [[ $live_height ]] && [[ $snap_height ]]; then
    let "snapheight_difference = $live_height - $snap_height"
  fi
  #current_info_height=5
  if [[ $live_height ]] && [[ $current_info_height ]]; then
    let "blockheight_difference = $live_height - $current_info_height"
  fi

  if [[ $blockheight_difference -ge 500 ]]; then
    echo "[$(date)] Big difference in blockheight, doing a fast sync..." >> /var/dashboard/logs/auto-maintain.log
    wget https://helium-snapshots.nebra.com/snap-$snap_height -O /home/pi/hnt/miner/snap/snap-latest
    docker exec miner miner repair sync_pause
    docker exec miner miner repair sync_cancel
    docker exec miner miner snapshot load /var/data/snap/snap-latest
    sleep 2m
    sync_state=$(docker exec miner miner repair sync_state)

    if [[ $sync_state == 'sync active' ]]; then
      docker exec miner miner repair sync_resume
    else
      sleep 2m
      docker exec miner miner repair sync_resume
    fi
  fi

  if [[ ! $pubkey ]]; then
    echo "[$(date)] Your public key is missing, trying a refresh..." >> /var/dashboard/logs/auto-maintain.log
    bash /etc/monitor-scripts/pubkeys.sh
  fi

  if [[ $miner_version ]] && [[ $latest_miner_version ]]; then
    if [[ $miner_version != $latest_miner_version ]]; then
      echo "[$(date)] Miner is out of date, trying a miner update..." >> /var/dashboard/logs/auto-maintain.log
      echo 'start' > /var/dashboard/services/miner-update
      bash /etc/monitor-scripts/miner-update.sh
    fi
  fi

  if [[ $dashboard_version != $latest_dashboard_version ]]; then
    echo echo "[$(date)] Dashboard is out of date (why don't you love me?), trying a dashboard update..." >> /var/dashboard/logs/auto-maintain.log
    echo 'start' > /var/dashboard/services/dashboard-update
    bash /etc/monitor-scripts/dashboard-update.sh
  fi

fi
