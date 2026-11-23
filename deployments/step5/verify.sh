#!/bin/bash
# Passes when the den-den Deployment is gone, and every pod a ReplicaSet made,
# including the stray one, is gone or on its way out.
! kubectl get deployment den-den >/dev/null 2>&1 || exit 1
for pod in $(kubectl get pods -l pod-template-hash -o name); do
  [ -n "$(kubectl get "$pod" -o jsonpath='{.metadata.deletionTimestamp}' 2>/dev/null)" ] || exit 1
done
