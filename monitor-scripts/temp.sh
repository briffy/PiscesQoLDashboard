#!/bin/bash

data=$(vcgencmd measure_temp)

if [[ $data =~ temp=(.*) ]]; then
  match="${BASH_REMATCH[1]}"
fi

echo $match > /var/dashboard/statuses/temp
