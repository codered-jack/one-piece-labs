#!/bin/bash
# Passes when the den-den Deployment asks for 2 copies, and 2 are ready.
[ "$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}' 2>/dev/null)" = "2" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "2" ]
