#!/bin/bash
# Passes when the lookout is a new container since step 3, the harbor_logbook
# volume is older than it (so the app went down and up, and the volume was
# kept), and den-den answers on localhost:9000.
# One `up` creates the volume and the containers within a second of each
# other; the 2-second margin tells that apart from a volume kept through
# `down`. A reader who ran `down -v` by mistake can recover with another
# `down` and `up`.
KEPT_VOLUME_MIN_AGE_SECONDS=2
before=$(cat /root/.harbor-lookout-id 2>/dev/null)
now=$(docker ps -q --no-trunc --filter label=com.docker.compose.project=harbor \
  --filter label=com.docker.compose.service=lookout)
[ -n "$before" ] && [ -n "$now" ] && [ "$before" != "$now" ] || exit 1
volume_created=$(docker volume inspect -f '{{.CreatedAt}}' harbor_logbook 2>/dev/null) || exit 1
lookout_created=$(docker inspect -f '{{.Created}}' "$now")
age=$(( $(date -d "$lookout_created" +%s) - $(date -d "$volume_created" +%s) )) || exit 1
[ "$age" -ge "$KEPT_VOLUME_MIN_AGE_SECONDS" ] || exit 1
[ "$(curl -s --max-time 5 localhost:9000)" = "Purupurupuru! Den Den Mushi here." ]
