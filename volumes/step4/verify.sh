#!/bin/bash
# Passes when visitor runs with /root/wanted bind-mounted read-only at /app:
# it can read crew.txt, and a test write fails. The write uses its own file
# name, so a writable mount can't overwrite crew.txt; any leftover is removed.
[ "$(docker inspect -f '{{.State.Running}}' visitor 2>/dev/null)" = "true" ] || exit 1
docker inspect -f '{{range .Mounts}}{{.Type}} {{.Source}} {{.Destination}} {{.RW}}{{"\n"}}{{end}}' visitor \
  | grep -qx 'bind /root/wanted /app false' || exit 1
[ "$(docker exec visitor cat /app/crew.txt 2>/dev/null)" = "Zoro" ] || exit 1
if docker exec visitor touch /app/.write-test 2>/dev/null; then
  rm -f /root/wanted/.write-test
  exit 1
fi
