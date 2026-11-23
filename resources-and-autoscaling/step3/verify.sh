#!/bin/bash
# Passes when the hungry pod's memory limit is 64Mi and its container has been
# killed for going over it, now or on an earlier try.
[ "$(kubectl get pod hungry -o jsonpath='{.spec.containers[0].resources.limits.memory}' 2>/dev/null)" = "64Mi" ] || exit 1
kubectl get pod hungry -o jsonpath='{.status.containerStatuses[0].state.terminated.reason} {.status.containerStatuses[0].lastState.terminated.reason}' | grep -q OOMKilled
