#!/bin/bash
ip=$(curl -4 icanhazip.com)
echo "Remote IP: " $ip > /var/dashboard/statuses/external-ip
