#!/bin/bash
# Passes when every part's container requests CPU and memory and has a memory
# limit, and every part has rolled out and is ready.
ns="-n bounty-board"
r='{.spec.template.spec.containers[0].resources'
for w in deployment/api deployment/web deployment/cache statefulset/db; do
  for f in requests.cpu requests.memory limits.memory; do
    [ -n "$(kubectl get "$w" $ns -o jsonpath="$r.$f}")" ] || exit 1
  done
done
for d in api web cache; do
  want=$(kubectl get deployment "$d" $ns -o jsonpath='{.spec.replicas}')
  for f in replicas readyReplicas updatedReplicas; do
    [ "$(kubectl get deployment "$d" $ns -o jsonpath="{.status.$f}")" = "$want" ] || exit 1
  done
done
[ "$(kubectl get statefulset db $ns -o jsonpath='{.status.readyReplicas}')" = "1" ] || exit 1
[ "$(kubectl get statefulset db $ns -o jsonpath='{.status.currentRevision}')" = "$(kubectl get statefulset db $ns -o jsonpath='{.status.updateRevision}')" ]
