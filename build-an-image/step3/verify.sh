#!/bin/bash
# Passes when wanted:v3 carries BOUNTY=30,000,000 as an image setting (so an
# edited wanted.py doesn't count) and still takes a name like v2.
docker image inspect -f '{{range .Config.Env}}{{println .}}{{end}}' wanted:v3 2>/dev/null \
  | grep -qx 'BOUNTY=30,000,000' || exit 1
[ "$(docker run --rm wanted:v3 2>/dev/null)" = "WANTED: Luffy - bounty 30,000,000 berries" ] || exit 1
[ "$(docker run --rm wanted:v3 Zoro 2>/dev/null)" = "WANTED: Zoro - bounty 30,000,000 berries" ]
