#!/bin/bash

data=$(sensors cpu_thermal-virtual-0 | grep temp1)

if [[ $data =~ temp1:(.*) ]]; then
  match="${BASH_REMATCH[1]}"
fi

echo $match > /var/dashboard/statuses/temp
