#!/bin/bash
# Passes when den-den runs on the fleet network and answers a call by name
# from another container on fleet.
[ "$(docker inspect -f '{{.State.Running}}' den-den 2>/dev/null)" = "true" ] || exit 1
docker inspect -f '{{range $name, $net := .NetworkSettings.Networks}}{{$name}}{{"\n"}}{{end}}' den-den \
  | grep -qx fleet || exit 1
[ "$(docker run --rm --network fleet alpine wget -qO- -T 5 http://den-den:8000 2>/dev/null)" = "Purupurupuru! Den Den Mushi here." ]
