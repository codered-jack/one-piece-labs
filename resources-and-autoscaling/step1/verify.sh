#!/bin/bash
# Passes when the den-den template requests 50m CPU and 32Mi memory, is
# limited to 200m CPU and 64Mi memory, and the rollout is done.
r='{.spec.template.spec.containers[0].resources'
[ "$(kubectl get deployment den-den -o jsonpath="$r.requests.cpu}" 2>/dev/null)" = "50m" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath="$r.requests.memory}")" = "32Mi" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath="$r.limits.cpu}")" = "200m" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath="$r.limits.memory}")" = "64Mi" ] || exit 1
want=$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}')
[ "$(kubectl get deployment den-den -o jsonpath='{.status.updatedReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "$want" ] || exit 1
