#!/bin/bash
# Passes when some container started from an alpine image ran `echo ahoy`
# and printed ahoy. Containers removed with --rm leave nothing to check.
for id in $(docker ps -aq); do
  image=$(docker inspect -f '{{.Config.Image}}' "$id")
  command=$(docker inspect -f '{{join .Config.Cmd " "}}' "$id")
  case "$image" in alpine | alpine:*) ;; *) continue ;; esac
  [ "$command" = "echo ahoy" ] || continue
  docker logs "$id" 2>/dev/null | grep -qx 'ahoy' && exit 0
done
exit 1
