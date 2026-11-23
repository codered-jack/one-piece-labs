#!/bin/bash
# Passes when the load pod exists and the den-den HPA has grown the
# Deployment past one copy.
kubectl get pod load >/dev/null 2>&1 || exit 1
n=$(kubectl get hpa den-den -o jsonpath='{.status.currentReplicas}' 2>/dev/null)
[ "${n:-0}" -gt 1 ]
