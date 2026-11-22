#!/bin/bash
# Passes when a container named lookout is running and has printed at least one report.
[ "$(docker inspect -f '{{.State.Running}}' lookout 2>/dev/null)" = "true" ] || exit 1
docker logs lookout 2>/dev/null | grep -qE '^Lookout report [0-9]+: all clear$'
