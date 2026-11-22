#!/bin/bash
# Passes when a running container named registry answers registry requests on localhost:5000.
[ "$(docker inspect -f '{{.State.Running}}' registry 2>/dev/null)" = "true" ] || exit 1
curl -fs -o /dev/null --max-time 3 http://localhost:5000/v2/
