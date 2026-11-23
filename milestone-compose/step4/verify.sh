#!/bin/bash
# Passes when db is a new container (so the app went down and came back up)
# and the board still lists Nico Robin.
before=$(cat /root/.bounty-board-db-id 2>/dev/null)
now=$(docker ps -q --no-trunc --filter label=com.docker.compose.project=bounty-board \
  --filter label=com.docker.compose.service=db)
[ -n "$before" ] && [ -n "$now" ] && [ "$before" != "$now" ] || exit 1
curl -s --max-time 5 localhost:9000/api/bounties \
  | grep -q '"bounty":930000000,"id":[0-9]*,"name":"Nico Robin"'
