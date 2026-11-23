#!/bin/bash
# Passes when ~/sunk.txt names a pod of the den-den ReplicaSet that no longer
# exists, and the Deployment has 3 copies ready again.
[ -f /root/sunk.txt ] || exit 1
pod=$(sed 's#^pod/##' /root/sunk.txt | tr -d '[:space:]')
match=no
for rs in $(kubectl get replicasets -l app=den-den -o jsonpath='{.items[*].metadata.name}'); do
  case "$pod" in "$rs"-?*) match=yes ;; esac
done
[ "$match" = "yes" ] || exit 1
! kubectl get pod "$pod" >/dev/null 2>&1 || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "3" ]
