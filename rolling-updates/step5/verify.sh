#!/bin/bash
# Passes when ~/revision.txt holds the den-den Deployment's current revision.
[ -f /root/revision.txt ] || exit 1
want=$(kubectl get deployment den-den -o jsonpath='{.metadata.annotations.deployment\.kubernetes\.io/revision}' 2>/dev/null)
[ -n "$want" ] && [ "$(tr -d '[:space:]' < /root/revision.txt)" = "$want" ]
