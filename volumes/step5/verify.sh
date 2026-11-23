#!/bin/bash
# Passes when deck and visitor are removed, the logbook volume is deleted, and
# crew.txt on the machine survived.
[ -z "$(docker ps -aq --filter name='^(deck|visitor)$')" ] || exit 1
! docker volume inspect logbook >/dev/null 2>&1 || exit 1
[ "$(cat /root/wanted/crew.txt 2>/dev/null)" = "Zoro" ]
