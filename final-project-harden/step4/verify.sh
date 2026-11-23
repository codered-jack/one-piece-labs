#!/bin/bash
# Passes when the budgets api and web each allow 1 missing pod of their app
# and currently allow a disruption, and no budget covers the database.
ns="-n bounty-board"
for app in api web; do
  p() { kubectl get pdb "$app" $ns -o jsonpath="$1" 2>/dev/null; }
  [ "$(p '{.spec.maxUnavailable}')" = "1" ] || exit 1
  [ "$(p '{.spec.selector.matchLabels.app}')" = "$app" ] || exit 1
  [ "$(p '{.status.disruptionsAllowed}')" -ge 1 ] 2>/dev/null || exit 1
done
kubectl get pdb $ns -o jsonpath='{range .items[*]}{.spec.selector.matchLabels.app}{"\n"}{end}' | grep -qx db && exit 1
exit 0
