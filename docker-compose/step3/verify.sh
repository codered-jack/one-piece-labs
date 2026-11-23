#!/bin/bash
# Passes when harbor's lookout is running with the harbor_logbook volume at
# /logbook, and the logbook holds at least one answer from den-den.
# It also saves the lookout's container ID, so step 4 can tell that the
# lookout was replaced.
lookout=$(docker ps -q --no-trunc --filter label=com.docker.compose.project=harbor \
  --filter label=com.docker.compose.service=lookout)
[ -n "$lookout" ] || exit 1
docker inspect -f '{{range .Mounts}}{{.Name}}:{{.Destination}} {{end}}' "$lookout" \
  | grep -q 'harbor_logbook:/logbook' || exit 1
docker exec "$lookout" grep -q 'Purupurupuru! Den Den Mushi here.' /logbook/calls.txt || exit 1
echo "$lookout" > /root/.harbor-lookout-id
