#!/bin/bash
# Passes when ~/fleet/den-den-deployment.yaml exists, and the den-den
# Deployment selects app=den-den, runs python:3.12-alpine, and has 3 of 3
# copies ready.
[ -f /root/fleet/den-den-deployment.yaml ] || exit 1
d() { kubectl get deployment den-den -o jsonpath="$1" 2>/dev/null; }
[ "$(d '{.spec.selector.matchLabels.app}')" = "den-den" ] || exit 1
[ "$(d '{.spec.template.spec.containers[0].image}')" = "python:3.12-alpine" ] || exit 1
[ "$(d '{.spec.replicas}')" = "3" ] || exit 1
[ "$(d '{.status.readyReplicas}')" = "3" ]
