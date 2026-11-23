#!/bin/bash
# Passes when the api Deployment asks for 3 copies, and 3 are ready.
[ "$(kubectl get deployment api -n bounty-board -o jsonpath='{.spec.replicas}' 2>/dev/null)" = "3" ] || exit 1
[ "$(kubectl get deployment api -n bounty-board -o jsonpath='{.status.readyReplicas}')" = "3" ]
