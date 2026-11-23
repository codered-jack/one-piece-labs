#!/bin/bash
# Passes when no pod with app=den-den is left, apart from ones on their way
# out, and the lookout and the cook are still there.
for pod in $(kubectl get pods -l app=den-den -o name); do
  [ -n "$(kubectl get "$pod" -o jsonpath='{.metadata.deletionTimestamp}' 2>/dev/null)" ] || exit 1
done
kubectl get pod lookout >/dev/null 2>&1 || exit 1
kubectl get pod cook >/dev/null 2>&1
