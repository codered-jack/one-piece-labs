#!/bin/bash
# Passes when the den-den Deployment is back on python:3.13-alpine, with all 3
# copies updated and ready, and no pod left on the broken image.
d() { kubectl get deployment den-den -o jsonpath="$1" 2>/dev/null; }
[ "$(d '{.spec.template.spec.containers[0].image}')" = "python:3.13-alpine" ] || exit 1
[ "$(d '{.status.updatedReplicas}')" = "3" ] || exit 1
[ "$(d '{.status.readyReplicas}')" = "3" ] || exit 1
[ "$(d '{.status.replicas}')" = "3" ]
