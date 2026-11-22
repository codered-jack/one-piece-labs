#!/bin/bash
# Passes when the lookout runs again, its count has started over at least once
# (report 1 appears twice in its log), and the note from step 3 survived, so
# it's the same container, not a new one.
[ "$(docker inspect -f '{{.State.Running}}' lookout 2>/dev/null)" = "true" ] || exit 1
[ "$(docker logs lookout 2>/dev/null | grep -c '^Lookout report 1: all clear$')" -ge 2 ] || exit 1
[ "$(docker exec lookout cat /note.txt 2>/dev/null)" = "ahoy" ]
