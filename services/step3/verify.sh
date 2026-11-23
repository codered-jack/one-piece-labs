#!/bin/bash
# Passes when the den-den Deployment has 5 copies ready, and the den-den
# Service lists 5 pod addresses.
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}' 2>/dev/null)" = "5" ] || exit 1
n=$(kubectl get endpointslices -l kubernetes.io/service-name=den-den -o jsonpath='{.items[*].endpoints[*].addresses[*]}' | wc -w)
[ "$n" -eq 5 ]
