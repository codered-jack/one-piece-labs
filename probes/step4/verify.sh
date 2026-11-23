#!/bin/bash
# Passes when the den-den template still has its liveness probe, and a current
# den-den pod has restarted at least once.
[ "$(kubectl get deployment den-den -o jsonpath='{.spec.template.spec.containers[0].livenessProbe.httpGet.path}' 2>/dev/null)" = "/alive" ] || exit 1
for pod in $(kubectl get pods -l app=den-den -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}'); do
  n=$(kubectl get pod "$pod" -o jsonpath='{.status.containerStatuses[0].restartCount}')
  [ "${n:-0}" -ge 1 ] && exit 0
done
exit 1
