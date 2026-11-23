#!/bin/bash
# Passes when harbor's den-den service is running and answers on localhost:9000.
[ -n "$(docker ps -q --filter label=com.docker.compose.project=harbor \
  --filter label=com.docker.compose.service=den-den)" ] || exit 1
[ "$(curl -s --max-time 5 localhost:9000)" = "Purupurupuru! Den Den Mushi here." ]
