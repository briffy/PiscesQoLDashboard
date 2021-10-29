#!/bin/bash
systemctl stop apache2.service
systemctl disable apache2.service

apt-get install nginx php-fpm php7.3-fpm

mkdir /var/dashboard
mkdir /etc/monitor-scripts

cp -r dashboard/* /var/dashboard/
cp monitor-scripts/* /etc/monitor-scripts/
cp nginx/certs/nginx-selfsigned.crt /etc/ssl/certs/
cp nginx/certs/nginx-selfsigned.key /etc/ssl/private/
cp nginx/snippets/* /etc/nginx/snippets/
cp nginx/default /etc/nginx/sites-enabled/
cp nginx/.htpasswd /var/dashboard/.htpasswd
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

systemctl enable bt-check.timer
systemctl enable bt-service-check.timer
systemctl enable fastsync-check.timer
systemctl enable gps-check.timer
systemctl enable helium-status-check.timer
systemctl enable infoheight-check.timer
systemctl enable miner-check.timer
systemctl enable miner-service-check.timer
systemctl enable peer-list-check.timer
systemctl enable pf-check.timer
systemctl enable pf-service-check.timer
systemctl enable pubkeys-check.timer
systemctl enable reboot-check.timer
systemctl enable temp-check.timer

systemctl start bt-check.timer
systemctl start bt-service-check.timer
systemctl start fastsync-check.timer
systemctl start gps-check.timer
systemctl start helium-status-check.timer
systemctl start infoheight-check.timer
systemctl start miner-check.timer
systemctl start miner-service-check.timer
systemctl start peer-list-check.timer
systemctl start pf-check.timer
systemctl start pf-service-check.timer
systemctl start pubkeys-check.timer
systemctl start reboot-check.timer
systemctl start temp-check.timer

systemctl start bt-check.service
systemctl start bt-service-check.service
systemctl start fastsync-check.service
systemctl start gps-check.service
systemctl start helium-status-check.service
systemctl start infoheight-check.service
systemctl start miner-check.service
systemctl start miner-service-check.service
systemctl start peer-list-check.service
systemctl start pf-check.service
systemctl start pf-service-check.service
systemctl start pubkeys-check.service
systemctl start reboot-check.service
systemctl start temp-check.service

systemctl enable nginx.service
systemctl start nginx.service
