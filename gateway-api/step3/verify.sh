#!/bin/bash
# Passes when HTTPRoute wanted attaches to front-door, matches the path prefix
# /wanted, sends it to the wanted Service on port 80, and resolves.
r='kubectl get httproute wanted -o jsonpath'
[ "$($r='{.spec.parentRefs[0].name}' 2>/dev/null)" = "front-door" ] || exit 1
[ "$($r='{.spec.rules[0].matches[0].path.type}')" = "PathPrefix" ] || exit 1
[ "$($r='{.spec.rules[0].matches[0].path.value}')" = "/wanted" ] || exit 1
[ "$($r='{.spec.rules[0].backendRefs[0].name}')" = "wanted" ] || exit 1
[ "$($r='{.spec.rules[0].backendRefs[0].port}')" = "80" ] || exit 1
[ "$($r='{.status.parents[0].conditions[?(@.type=="Accepted")].status}')" = "True" ] || exit 1
[ "$($r='{.status.parents[0].conditions[?(@.type=="ResolvedRefs")].status}')" = "True" ]
