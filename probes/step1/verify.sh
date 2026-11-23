#!/bin/bash
# Passes when the den-den template has a readiness probe asking for /ready on
# port 8000, and the rollout is done.
c='{.spec.template.spec.containers[0].readinessProbe.httpGet'
[ "$(kubectl get deployment den-den -o jsonpath="$c.path}" 2>/dev/null)" = "/ready" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath="$c.port}")" = "8000" ] || exit 1
want=$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}')
[ "$(kubectl get deployment den-den -o jsonpath='{.status.updatedReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "$want" ] || exit 1
