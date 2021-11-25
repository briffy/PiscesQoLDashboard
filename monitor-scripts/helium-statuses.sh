#!/bin/bash
pubkey=$(</var/dashboard/statuses/pubkey)
root_uri='https://api.helium.io/v1/hotspots/'
activity_uri="/activity"
uri="$root_uri$pubkey"
recent_activity_uri="$uri$activity_uri"

data=$(wget -qO- $uri)
recent_activity=$(curl -s $recent_activity_uri)
echo $recent_activity_uri

height=$(wget -qO- 'https://api.helium.io/v1/blocks/height' | grep -Po '"height":[^}]+' | sed -e 's/^"height"://')
online_status=$(echo $data | grep -Po '"online":".*?[^\\]"' | sed -e 's/^"online"://' | tr -d '"')
lat=$(echo $data | grep -Po '"lat":[^\,]+' | sed -e 's/^"lat"://')
lng=$(echo $data | grep -Po '"lng":[^\,]+' | sed -e 's/^"lng"://')


if [[ $pubkey ]]; then
  echo $online_status > /var/dashboard/statuses/online_status
else
  echo 'unknown' > /var/dashboard/statuses/online_status
fi

echo $lat > /var/dashboard/statuses/lat
echo $lng > /var/dashboard/statuses/lng
echo $height > /var/dashboard/statuses/current_blockheight
echo $recent_activity > /var/dashboard/statuses/recent_activity
bash /etc/monitor-scripts/info-height.sh
