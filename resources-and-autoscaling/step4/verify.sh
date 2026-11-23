#!/bin/bash
# Passes when den-den-deployment.yaml no longer sets replicas, the den-den HPA
# targets the den-den Deployment with 1 to 5 copies at 50% CPU, and it has
# real numbers from metrics-server.
grep -q 'replicas:' /root/fleet/den-den-deployment.yaml 2>/dev/null && exit 1
[ -f /root/fleet/den-den-deployment.yaml ] || exit 1
[ "$(kubectl get hpa den-den -o jsonpath='{.spec.scaleTargetRef.kind}/{.spec.scaleTargetRef.name}' 2>/dev/null)" = "Deployment/den-den" ] || exit 1
[ "$(kubectl get hpa den-den -o jsonpath='{.spec.minReplicas}-{.spec.maxReplicas}')" = "1-5" ] || exit 1
[ "$(kubectl get hpa den-den -o jsonpath='{.spec.metrics[0].resource.name}/{.spec.metrics[0].resource.target.averageUtilization}')" = "cpu/50" ] || exit 1
[ -n "$(kubectl get hpa den-den -o jsonpath='{.status.currentMetrics[0].resource.current.averageUtilization}')" ] || exit 1
