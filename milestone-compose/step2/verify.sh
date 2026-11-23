#!/bin/bash
# Passes when all four Bounty Board services are running and the health page
# answers 200 (database and cache both up).
running=$(docker ps --filter label=com.docker.compose.project=bounty-board \
  --format '{{.Label "com.docker.compose.service"}}' | sort | tr '\n' ' ')
[ "$running" = "api cache db web " ] || exit 1
[ "$(curl -s -o /dev/null -w '%{http_code}' --max-time 5 localhost:9000/api/health)" = "200" ]
