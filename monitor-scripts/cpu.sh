#!/bin/bash
idle=$(top -b -n 1 | grep -Po '%Cpu\(s\): *.+' | grep -Po '[0-9.]+ id,' | sed 's/id,//' |  awk '{print int($1+0.5)}')

used=$(expr 100 - $idle)
echo $used > /var/dashboard/statuses/cpu
