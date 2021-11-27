#!/bin/bash
sn=$(curl -s 'http://localhost:8001/api/test/minerSn/read')
echo $sn | grep -Po '"minerSn":[^\,]+' | sed -e 's/^"minerSn"://' | tr -d '"' | tr -d ' ' > /var/dashboard/statuses/sn
