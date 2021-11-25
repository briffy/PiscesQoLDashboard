#!/bin/bash
docker exec miner miner peer book -s > /var/dashboard/statuses/peerlist
