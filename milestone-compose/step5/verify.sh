#!/bin/bash
# Passes when cache isn't running, the board still answers 200 from the
# database, and the health page answers 503.
running=$(docker ps --filter label=com.docker.compose.project=bounty-board \
  --format '{{.Label "com.docker.compose.service"}}' | sort | tr '\n' ' ')
[ "$running" = "api db web " ] || exit 1
board=$(curl -s -w ' %{http_code}' --max-time 10 localhost:9000/api/bounties)
case "$board" in *'"source":"database"'*' 200') ;; *) exit 1 ;; esac
[ "$(curl -s -o /dev/null -w '%{http_code}' --max-time 10 localhost:9000/api/health)" = "503" ]
