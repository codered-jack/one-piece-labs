#!/bin/bash
# Passes when the board lists Nico Robin with a bounty of 930000000.
# It also saves the db container's ID, so step 4 can tell that db was
# removed and created again.
curl -s --max-time 5 localhost:9000/api/bounties \
  | grep -q '"bounty":930000000,"id":[0-9]*,"name":"Nico Robin"' || exit 1
docker ps -q --no-trunc --filter label=com.docker.compose.project=bounty-board \
  --filter label=com.docker.compose.service=db > /root/.bounty-board-db-id
[ -s /root/.bounty-board-db-id ]
