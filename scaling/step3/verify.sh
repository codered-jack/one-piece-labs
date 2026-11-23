#!/bin/bash
# Passes when ~/fleet/den-den-deployment.yaml says replicas: 4, and the
# den-den Deployment asks for 4 copies with 4 ready.
grep -Eq '^[[:space:]]*replicas:[[:space:]]*4[[:space:]]*$' /root/fleet/den-den-deployment.yaml || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}' 2>/dev/null)" = "4" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "4" ]
