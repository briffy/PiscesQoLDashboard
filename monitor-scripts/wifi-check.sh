#!/bin/bash
ip -o -4 addr list wlan0 | awk '{print $4}' | cut -d/ -f1 > /var/dashboard/statuses/wifi
