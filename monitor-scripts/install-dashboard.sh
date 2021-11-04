#!/bin/bash
systemctl stop apache2.service
systemctl disable apache2.service

systemctl start nginx
systemctl enable nginx
