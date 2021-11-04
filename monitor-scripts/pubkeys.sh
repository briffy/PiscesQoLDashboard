#!/bin/bash

data=$(sudo docker exec miner miner print_keys)

if [[ $data =~ animal_name,\"([^\"]*) ]]; then
  match="${BASH_REMATCH[1]}"
fi

echo "${match//-/ }" > /var/dashboard/statuses/animal_name

if [[ $data =~ pubkey,\"([^\"]*) ]]; then
  match="${BASH_REMATCH[1]}"
fi

echo $match > /var/dashboard/statuses/pubkey
