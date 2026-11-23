#!/bin/bash
# Passes when Gateway front-door is programmed, and a call through it, from
# inside a web pod, lists Nico Robin at 930000000. That proves the /api rule
# reaches the API.
ns="-n bounty-board"
[ "$(kubectl get gateway front-door $ns -o jsonpath='{.status.conditions[?(@.type=="Programmed")].status}' 2>/dev/null)" = "True" ] || exit 1
list=$(kubectl exec $ns deploy/web -- wget -qO- -T 3 http://front-door-nginx/api/bounties 2>/dev/null)
printf '%s' "$list" | grep -q '"bounty":930000000,"id":[0-9]*,"name":"Nico Robin"' || exit 1
kubectl exec $ns deploy/web -- wget -qO- -T 3 http://front-door-nginx/ 2>/dev/null | grep -q "<title>The Bounty Board</title>"
