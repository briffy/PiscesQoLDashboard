#!/bin/bash
check=$(</var/dashboard/statuses/reboot)

if [[ $check == true ]]; then
  echo 'false' > /var/dashboard/statuses/reboot
  reboot
fi
