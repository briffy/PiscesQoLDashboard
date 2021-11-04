#!/bin/bash

data=$(head -10 /dev/serial0)


if [ ${#data} -ge 7 ];
then
    echo 1 > /var/dashboard/statuses/gps
else
    echo 0 > /var/dashboard/statuses/gps
fi
