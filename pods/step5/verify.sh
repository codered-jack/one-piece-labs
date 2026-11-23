#!/bin/bash
# Passes when the den-den and watchtower pods are gone, or on their way out.
for pod in den-den watchtower; do
  if kubectl get pod "$pod" >/dev/null 2>&1; then
    [ -n "$(kubectl get pod "$pod" -o jsonpath='{.metadata.deletionTimestamp}')" ] || exit 1
  fi
done
