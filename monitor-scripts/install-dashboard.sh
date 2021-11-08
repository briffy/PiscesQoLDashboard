#!/bin/bash
systemctl stop apache2.service
systemctl disable apache2.service

sleep 5

systemctl start nginx
systemctl enable nginx

systemctl start php7.3-fpm.service
systemctl enable php7.3-fpm.service