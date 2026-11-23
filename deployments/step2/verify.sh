#!/bin/bash
# Passes when ~/replicaset.txt holds the name of the den-den ReplicaSet,
# with or without the replicaset.apps/ prefix that -o name adds.
[ -f /root/replicaset.txt ] || exit 1
got=$(sed 's#^replicaset.apps/##' /root/replicaset.txt | tr -d '[:space:]')
[ -n "$got" ] || exit 1
for rs in $(kubectl get replicasets -l app=den-den -o jsonpath='{.items[*].metadata.name}'); do
  [ "$got" = "$rs" ] && exit 0
done
exit 1
