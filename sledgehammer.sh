#!/bin/bash
for f in /home/pi/hnt/miner/blockchain.db/*;
do
  rm -rfv "$f"
done
