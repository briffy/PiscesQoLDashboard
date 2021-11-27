#!/bin/bash
if test -f /var/dashboard/password; then
  password=$(</var/dashboard/password)
  echo 'admin:'$password | chpasswd
  rm /var/dashboard/password
fi
