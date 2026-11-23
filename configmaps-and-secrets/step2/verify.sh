#!/bin/bash
# Passes when the den-den template takes its settings from ship-settings, the
# rollout is done, and every den-den pod's page names the Going Merry. Pods on
# their way out still serve their old page, so they're skipped.
template=$(kubectl get deployment den-den -o jsonpath='{.spec.template.spec.containers[0].envFrom[*].configMapRef.name} {.spec.template.spec.containers[0].env[*].valueFrom.configMapKeyRef.name}' 2>/dev/null)
printf '%s' "$template" | grep -qw ship-settings || exit 1
want=$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}')
[ "$(kubectl get deployment den-den -o jsonpath='{.status.updatedReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "$want" ] || exit 1
for pod in $(kubectl get pods -l app=den-den --field-selector=status.phase=Running -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}'); do
  kubectl exec "$pod" -- cat index.html 2>/dev/null | grep -q "The Going Merry calling" || exit 1
done
