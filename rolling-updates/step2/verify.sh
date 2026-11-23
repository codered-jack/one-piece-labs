#!/bin/bash
# Passes when the file and the den-den Deployment both say python:3.13-alpine,
# and all 3 copies are updated and ready, with no old copies left.
grep -q 'image: python:3.13-alpine' /root/fleet/den-den-deployment.yaml 2>/dev/null || exit 1
d() { kubectl get deployment den-den -o jsonpath="$1" 2>/dev/null; }
[ "$(d '{.spec.template.spec.containers[0].image}')" = "python:3.13-alpine" ] || exit 1
[ "$(d '{.status.updatedReplicas}')" = "3" ] || exit 1
[ "$(d '{.status.readyReplicas}')" = "3" ] || exit 1
[ "$(d '{.status.replicas}')" = "3" ]
