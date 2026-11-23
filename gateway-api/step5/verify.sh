#!/bin/bash
# Passes when HTTPRoute logbook still matches /logbook, now sends it to the
# logbook Service, and resolves.
r='kubectl get httproute logbook -o jsonpath'
[ "$($r='{.spec.rules[0].matches[0].path.value}' 2>/dev/null)" = "/logbook" ] || exit 1
[ "$($r='{.spec.rules[0].backendRefs[0].name}')" = "logbook" ] || exit 1
[ "$($r='{.status.parents[0].conditions[?(@.type=="ResolvedRefs")].status}')" = "True" ]
