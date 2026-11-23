#!/bin/bash
# Passes when a bridge network named fleet exists.
[ "$(docker network inspect -f '{{.Driver}}' fleet 2>/dev/null)" = "bridge" ]
