#!/bin/bash

data=$(sudo /home/pi/config/_build/prod/rel/gateway_config/bin/gateway_config advertise status)

echo $data > /var/dashboard/statuses/bt
