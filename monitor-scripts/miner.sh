#!/bin/bash
sudo docker inspect --format "{{.State.Running}}" miner > /var/dashboard/statuses/miner
