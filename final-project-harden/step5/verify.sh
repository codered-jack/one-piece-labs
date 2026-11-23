#!/bin/bash
# Passes when the API's container sleeps at least 1 second in preStop and the
# Deployment has rolled out with every copy ready.
ns="-n bounty-board"
s=$(kubectl get deployment api $ns -o jsonpath='{.spec.template.spec.containers[0].lifecycle.preStop.sleep.seconds}')
[ "${s:-0}" -ge 1 ] || exit 1
want=$(kubectl get deployment api $ns -o jsonpath='{.spec.replicas}')
for f in replicas readyReplicas updatedReplicas; do
  [ "$(kubectl get deployment api $ns -o jsonpath="{.status.$f}")" = "$want" ] || exit 1
done
