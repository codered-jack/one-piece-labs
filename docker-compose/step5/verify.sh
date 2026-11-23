#!/bin/bash
# Passes when no harbor container is left, running or stopped, and its volume
# and network are gone.
[ -z "$(docker ps -aq --filter label=com.docker.compose.project=harbor)" ] || exit 1
! docker volume inspect harbor_logbook >/dev/null 2>&1 || exit 1
! docker network inspect harbor_default >/dev/null 2>&1
