#!/bin/bash
if ! id "admin" &> /dev/null; then
  adduser --disabled-password --gecos "" admin
  echo admin:admin | chpasswd
  usermod admin -g sudo
fi


if id -nG admin | grep -qw "sudo"; then
  rm -rf /tmp/latest.tar.gz
  wget --no-cache https://raw.githubusercontent.com/briffy/PiscesQoLDashboard/main/latest.tar.gz -O /tmp/latest.tar.gz
  cd /tmp
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
    chown root:www-data /var/dashboard
    chmod 775 /var/dashboard

    systemctl daemon-reload

    FILES="systemd/*.timer"
    for f in $FILES;
      do
        name=$(echo $f | sed 's/.timer//' | sed 's/systemd\///')
        systemctl start $name.timer
        systemctl enable $name.timer
        systemctl start $name.service
      done
    echo 'Success.'
  else
    echo 'No installation archive found.  No changes made.'
  fi
else
  echo 'Error checking if admin user exists.  No changes made.'
fi
