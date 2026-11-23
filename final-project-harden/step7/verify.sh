#!/bin/bash
# Passes when the load pod exists, the HPA measures the API above its 50%
# target, and it runs more than 2 copies.
ns="-n bounty-board"
kubectl get pod load $ns >/dev/null 2>&1 || exit 1
u=$(kubectl get hpa api $ns -o jsonpath='{.status.currentMetrics[0].resource.current.averageUtilization}')
[ "${u:-0}" -gt 50 ] || exit 1
n=$(kubectl get hpa api $ns -o jsonpath='{.status.currentReplicas}')
[ "${n:-0}" -gt 2 ]
