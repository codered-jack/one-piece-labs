#!/bin/bash
# Passes when no Bounty Board container is left, running or stopped, and its
# data volume is gone.
[ -z "$(docker ps -aq --filter label=com.docker.compose.project=bounty-board)" ] || exit 1
! docker volume inspect bounty-board_bounty-data >/dev/null 2>&1
