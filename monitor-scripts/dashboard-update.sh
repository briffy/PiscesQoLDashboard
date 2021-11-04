#!/bin/bash
service=$(cat /var/dashboard/services/dashboard-update | tr -d '\n')

if [[ $service == 'start' ]]; then
  echo 'running' > /var/dashboard/services/dashboard-update
  echo 'Downloading latest release...' > /var/dashboard/logs/dashboard-update.log
  cd /tmp
  wget https://raw.githubusercontent.com/briffy/PiscesQoLDashboard/main/latest.tar.gz
  echo 'Extracting contents...' >> /var/dashboard/logs/dashboard-update.log
  if test -f latest.tar.gz; then
    tar -xzf latest.tar.gz
    cd dashboardinstall
    cp -r dashboard/* /var/dashboard/
    cp monitor-scripts/* /etc/monitor-scripts/
    cp systemd/* /etc/systemd/system/
    chmod 755 /etc/monitor-scripts/*
    chown root:www-data /var/dashboard/services/*
    chown root:www-data /var/dashboard/statuses/*
    chmod 775 /var/dashboard/services/*
    chmod 775 /var/dashboard/statuses/*
    cd systemd
    echo 'Starting and enabling services...' >> /var/dashboard/logs/dashboard-update.log
    FILES="*.timer"
    for f in $FILES;
    do
      name=$(echo $f | sed 's/.timer//')
      systemctl daemon-reload >> /var/dashboard/logs/dashboard-update.log
      systemctl start $name.timer >> /var/dashboard/logs/dashboard-update.log
      systemctl enable $name.timer >> /var/dashboard/logs/dashboard-update.log
      systemctl start $name.service >> /var/dashboard/logs/dashboard-update.log
    done
  fi
fi
