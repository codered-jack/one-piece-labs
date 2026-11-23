#!/bin/bash
# Passes when the den-den Deployment asks for 5 copies, and 5 are ready.
[ "$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}' 2>/dev/null)" = "5" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "5" ]
