#!/bin/bash
# Passes when final/api.yaml and the Deployment both use bounty-board-api:1.1,
# the update has finished with every copy ready, and ~/update.txt has answered
# calls and no FAILED ones.
ns="-n bounty-board"
grep -q "image: bounty-board-api:1.1" /root/one-piece-labs/bounty-board/final/api.yaml || exit 1
[ "$(kubectl get deployment api $ns -o jsonpath='{.spec.template.spec.containers[0].image}')" = "bounty-board-api:1.1" ] || exit 1
want=$(kubectl get deployment api $ns -o jsonpath='{.spec.replicas}')
for f in replicas readyReplicas updatedReplicas; do
  [ "$(kubectl get deployment api $ns -o jsonpath="{.status.$f}")" = "$want" ] || exit 1
done
grep -q "answered" /root/update.txt 2>/dev/null || exit 1
grep -q "FAILED" /root/update.txt && exit 1
exit 0
