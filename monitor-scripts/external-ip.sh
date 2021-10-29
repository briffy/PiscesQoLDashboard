#!/bin/bash
ip=$(host myip.opendns.com resolver1.opendns.com | grep -Po 'has address *.+' | sed -e 's/^has address //')
echo "Remote IP: " $ip > /var/dashboard/statuses/external-ip
