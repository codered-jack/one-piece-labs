#!/bin/bash
# Passes when the den-den Deployment asks for python:3.99-alpine, a pod on
# that image is stuck pulling it, and 3 copies are still ready.
d() { kubectl get deployment den-den -o jsonpath="$1" 2>/dev/null; }
[ "$(d '{.spec.template.spec.containers[0].image}')" = "python:3.99-alpine" ] || exit 1
[ "$(d '{.status.readyReplicas}')" = "3" ] || exit 1
kubectl get pods -l app=den-den -o jsonpath='{.items[*].status.containerStatuses[*].state.waiting.reason}' | grep -Eq 'ErrImagePull|ImagePullBackOff'
