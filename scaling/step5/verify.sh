#!/bin/bash
# Passes when the den-den Deployment asks for 4 copies, as the file says,
# and 4 are ready.
[ "$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}' 2>/dev/null)" = "4" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "4" ]
