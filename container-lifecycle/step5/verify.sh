#!/bin/bash
# Passes when flaky has a policy that restarts it on failure, Docker has
# restarted it at least once, and its log shows it crashing.
policy=$(docker inspect -f '{{.HostConfig.RestartPolicy.Name}}' flaky 2>/dev/null)
case "$policy" in
  on-failure|always|unless-stopped) ;;
  *) exit 1 ;;
esac
[ "$(docker inspect -f '{{.RestartCount}}' flaky 2>/dev/null)" -ge 1 ] || exit 1
docker logs flaky 2>/dev/null | grep -q '^Hit a reef!$'
