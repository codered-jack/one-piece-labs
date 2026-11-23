#!/bin/bash
# Passes when HTTPRoute den-den attaches to front-door, sends calls to the
# den-den Service on port 80, and is accepted with all references resolved.
r='kubectl get httproute den-den -o jsonpath'
[ "$($r='{.spec.parentRefs[0].name}' 2>/dev/null)" = "front-door" ] || exit 1
[ "$($r='{.spec.rules[0].backendRefs[0].name}')" = "den-den" ] || exit 1
[ "$($r='{.spec.rules[0].backendRefs[0].port}')" = "80" ] || exit 1
[ "$($r='{.status.parents[0].conditions[?(@.type=="Accepted")].status}')" = "True" ] || exit 1
[ "$($r='{.status.parents[0].conditions[?(@.type=="ResolvedRefs")].status}')" = "True" ]
