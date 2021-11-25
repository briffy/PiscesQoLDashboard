#!/bin/bash
file=/var/dashboard/wifi_config

if [ -f "$file" ]; then
  mv /var/dashboard/wifi_config /etc/wpa_supplicant/wpa_supplicant.conf
fi

