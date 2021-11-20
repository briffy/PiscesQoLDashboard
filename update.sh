#!/bin/bash
systemctl disable bt-check.timer
systemctl disable bt-service-check.timer
systemctl disable clear-blockchain-check.timer
systemctl disable cpu-check.timer
systemctl disable external-ip-check.timer
systemctl disable fastsync-check.timer
systemctl disable gps-check.timer
systemctl disable helium-status-check.timer
systemctl disable infoheight-check.timer
systemctl disable local-ip-check.timer 
systemctl disable miner-check.timer
systemctl disable miner-service-check.timer 
systemctl disable miner-version-check.timer
systemctl disable password-check.timer
systemctl disable peer-list-check.timer
systemctl disable pf-check.timer
systemctl disable pf-service-check.timer
systemctl disable pubkeys-check.timer
systemctl disable reboot-check.timer
systemctl disable sn-check.timer
systemctl disable temp-check.timer
systemctl disable update-check.timer
systemctl disable update-dashboard-check.timer
systemctl disable update-miner-check.timer
systemctl disable wifi-check.timer
systemctl disable wifi-config-check.timer
systemctl disable wifi-service-check.timer
deluser admin
systemctl enable apache2
systemctl disable nginx
reboot
