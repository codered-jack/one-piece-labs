#!/bin/bash
# Passes when a running den-den pod is not ready, has never restarted, and is
# missing its ready file. A freshly started pod is also not ready for its
# first 10 seconds, so the missing file is what tells the two apart.
for pod in $(kubectl get pods -l app=den-den --field-selector=status.phase=Running -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}'); do
  [ "$(kubectl get pod "$pod" -o jsonpath='{.status.containerStatuses[0].ready}')" = "false" ] || continue
  [ "$(kubectl get pod "$pod" -o jsonpath='{.status.containerStatuses[0].restartCount}')" = "0" ] || continue
  kubectl exec "$pod" -- test -e ready 2>/dev/null && continue
  kubectl exec "$pod" -- test -e index.html 2>/dev/null && exit 0
done
exit 1
