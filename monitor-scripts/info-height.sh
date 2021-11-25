#!/bin/bash
sudo docker exec miner miner info height | grep -Po '\t\t[0-9]*' | sed 's/\t\t//' > /var/dashboard/statuses/infoheight
