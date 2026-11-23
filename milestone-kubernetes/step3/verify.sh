#!/bin/bash
# Passes when the four Bounty Board Deployments in bounty-board each have all
# their copies ready.
for d in web api cache db; do
  want=$(kubectl get deployment "$d" -n bounty-board -o jsonpath='{.spec.replicas}' 2>/dev/null)
  [ -n "$want" ] || exit 1
  [ "$(kubectl get deployment "$d" -n bounty-board -o jsonpath='{.status.readyReplicas}')" = "$want" ] || exit 1
done
