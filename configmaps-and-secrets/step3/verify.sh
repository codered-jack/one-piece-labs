#!/bin/bash
# Passes when ship-settings says Thousand Sunny, the rollout is done, and every
# den-den pod's page names the Thousand Sunny. Pods on their way out still
# serve their old page, so they're skipped.
[ "$(kubectl get configmap ship-settings -o jsonpath='{.data.SHIP}' 2>/dev/null)" = "Thousand Sunny" ] || exit 1
want=$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}')
[ "$(kubectl get deployment den-den -o jsonpath='{.status.updatedReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "$want" ] || exit 1
pods=$(kubectl get pods -l app=den-den --field-selector=status.phase=Running -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}')
[ -n "$pods" ] || exit 1
for pod in $pods; do
  kubectl exec "$pod" -- cat index.html 2>/dev/null | grep -q "The Thousand Sunny calling" || exit 1
done
