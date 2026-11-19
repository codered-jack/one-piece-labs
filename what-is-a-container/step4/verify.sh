#!/bin/bash
# Passes when a running container named napper runs `sleep 3600`.
state=$(docker inspect -f '{{.State.Running}} {{join .Config.Cmd " "}}' napper 2>/dev/null)
[ "$state" = "true sleep 3600" ]
