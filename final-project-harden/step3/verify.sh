#!/bin/bash
# Passes when the HPA api targets the api Deployment with 2 to 5 copies at 50%
# CPU and has measured it, and replicas is gone from both final/api.yaml and
# the last applied version of the Deployment.
ns="-n bounty-board"
h() { kubectl get hpa api $ns -o jsonpath="$1" 2>/dev/null; }
[ "$(h '{.spec.scaleTargetRef.kind}/{.spec.scaleTargetRef.name}')" = "Deployment/api" ] || exit 1
[ "$(h '{.spec.minReplicas}-{.spec.maxReplicas}')" = "2-5" ] || exit 1
[ "$(h '{.spec.metrics[0].resource.name}')" = "cpu" ] || exit 1
[ "$(h '{.spec.metrics[0].resource.target.averageUtilization}')" = "50" ] || exit 1
[ -n "$(h '{.status.currentMetrics[0].resource.current.averageUtilization}')" ] || exit 1
grep -Eq '^[[:space:]]*replicas:' /root/one-piece-labs/bounty-board/final/api.yaml && exit 1
kubectl get deployment api $ns -o jsonpath='{.metadata.annotations.kubectl\.kubernetes\.io/last-applied-configuration}' | grep -q '"replicas"' && exit 1
exit 0
