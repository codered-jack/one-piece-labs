#!/bin/bash
# Passes when the giant pod requests 20 CPUs and the scheduler has turned it
# down for lack of CPU.
[ "$(kubectl get pod giant -o jsonpath='{.spec.containers[0].resources.requests.cpu}' 2>/dev/null)" = "20" ] || exit 1
[ "$(kubectl get pod giant -o jsonpath='{.status.phase}')" = "Pending" ] || exit 1
kubectl get pod giant -o jsonpath='{.status.conditions[?(@.type=="PodScheduled")].message}' | grep -q "Insufficient cpu"
