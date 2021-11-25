#!/bin/bash
name="clear-blockchain"
service=$(cat /var/dashboard/services/$name | tr -d '\n')

if [[ $service == 'start' ]]; then
  echo 'running' > /var/dashboard/services/$name
  echo 'Stopping currently running docker...' > /var/dashboard/logs/$name.log
  docker stop miner >> /var/dashboard/logs/$name.log
  docker kill miner >> /var/dashboard/logs/$name.log
  currentdockerstatus=$(sudo docker ps -a -f name=miner --format "{{ .Status }}")
  if [[ $currentdockerstatus =~ 'Exited' || $currentdockerstatus == '' || $currentdockerstatus =~ 'Restarting' ]]; then
    echo 'Clearing Blockchain folders...' >> /var/dashboard/logs/$name.log
    rm -rfv /home/pi/hnt/miner/blockchain.db/* >> /var/dashboard/logs/$name.log
    rm -rfv /home/pi/hnt/miner/ledger.db/* >> /var/dashboard/logs/$name.log
    docker start miner
    currentdockerstatus=$(sudo docker ps -a -f name=miner --format "{{ .Status }}")
    if [[ $currentdockerstatus =~ 'Up' ]]; then
      echo 'stopped' > /var/dashboard/services/$name
      echo '------------------------------------------' >> /var/dashboard/logs/$name.log
      echo 'Task completed.' >> /var/dashboard/logs/$name.log
    else
      echo 'stopped' > /var/dashboard/services/$name
      echo '------------------------------------------' >> /var/dashboard/logs/$name.log
      echo 'Miner docker failed to start.  Check logs to investigate.' >> /var/dashboard/logs/$name.log
    fi
  else
    echo 'stopped' > /var/dashboard/services/$name
    echo '------------------------------------------' >> /var/dashboard/logs/$name.log
    echo 'Error: Could not stop docker.' >> /var/dashboard/logs/$name.log
  fi
fi
