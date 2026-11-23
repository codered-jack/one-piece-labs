#!/bin/bash
# Passes when deck runs with /root/wanted bind-mounted at /app, and reads
# crew.txt, created on the machine, as "Zoro".
[ "$(docker inspect -f '{{.State.Running}}' deck 2>/dev/null)" = "true" ] || exit 1
docker inspect -f '{{range .Mounts}}{{.Type}} {{.Source}} {{.Destination}}{{"\n"}}{{end}}' deck \
  | grep -qx 'bind /root/wanted /app' || exit 1
[ "$(cat /root/wanted/crew.txt 2>/dev/null)" = "Zoro" ] || exit 1
[ "$(docker exec deck cat /app/crew.txt 2>/dev/null)" = "Zoro" ]
