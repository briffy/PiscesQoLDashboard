#!/bin/bash
userdel admin2
userdel admin
groupdel admin
groupdel admin2
rm -rf /home/admin
rm -rf /home/admin2

adduser --disabled-password --gecos "" admin
echo admin:admin | chpasswd
usermod admin -g sudo


if id -nG admin | grep -qw "sudo"; then
  wget https://raw.githubusercontent.com/briffy/PiscesQoLDashboard/main/latest.tar.gz -O /tmp/latest.tar.gz
  cd /tmp
  if test -f latest.tar.gz; then
    tar -xzf latest.tar.gz
    cd dashboardinstall
    systemctl stop pm2-pi.service
    systemctl disable pm2-pi.service
    apt-get update
    apt-get --assume-yes install nginx php-fpm php7.3-fpm

    mkdir /var/dashboard
    mkdir /etc/monitor-scripts

    cp -r dashboard/* /var/dashboard/
    cp monitor-scripts/* /etc/monitor-scripts/
    cp nginx/certs/nginx-selfsigned.crt /etc/ssl/certs/
    cp nginx/certs/nginx-selfsigned.key /etc/ssl/private/
    cp nginx/snippets/* /etc/nginx/snippets/
    cp nginx/default /etc/nginx/sites-enabled
    if ! test -f /var/dashboard/.htpasswd; then
      cp nginx/.htpasswd /var/dashboard/.htpasswd
    fi
    cp nginx/dhparam.pem /etc/ssl/certs/dhparam.pem
    cp systemd/* /etc/systemd/system/

    chmod 755 /etc/monitor-scripts/*
    chown root:www-data /var/dashboard/services/*
    chown root:www-data /var/dashboard/statuses/*
    chmod 775 /var/dashboard/services/*
    chmod 775 /var/dashboard/statuses/*
    chown root:root /etc/ssl/private/nginx-selfsigned.key
    chmod 600 /etc/ssl/private/nginx-selfsigned.key
    chown root:root /etc/ssl/certs/nginx-selfsigned.crt
    chmod 777 /etc/ssl/certs/nginx-selfsigned.crt
    chown root:www-data /var/dashboard/.htpasswd
    chmod 775 /var/dashboard/.htpasswd
    chown root:www-data /var/dashboard
    chmod 775 /var/dashboard

    FILES="systemd/*.timer"
    for f in $FILES;
    do
       name=$(echo $f | sed 's/.timer//' | sed 's/systemd\///')
       systemctl start $name.timer
       systemctl enable $name.timer
       systemctl start $name.service
    done

    systemctl start install-dashboard.service

    echo 'Success.'
  else
    echo 'No installation archive found.  No changes made.'
  fi
else
  echo 'Error checking if admin user exists.  No changes made.';
fi
