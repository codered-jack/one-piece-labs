#!/bin/bash
# Passes when the Bounty Board lists Nico Robin at 930000000. It asks the app
# from inside a web pod, so it doesn't depend on the learner's port-forward.
list=$(kubectl exec -n bounty-board deploy/web -- wget -qO- http://127.0.0.1/api/bounties 2>/dev/null)
printf '%s' "$list" | grep -q '"bounty":930000000,"id":[0-9]*,"name":"Nico Robin"'
