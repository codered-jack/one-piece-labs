#!/bin/bash
# Passes when the den-den template has a liveness probe on /alive every 2
# seconds, and a startup probe on /alive allowing at least 30 seconds to
# start; the rollout is done, and no current den-den pod has restarted.
c='{.spec.template.spec.containers[0]'
[ "$(kubectl get deployment den-den -o jsonpath="$c.livenessProbe.httpGet.path}" 2>/dev/null)" = "/alive" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath="$c.livenessProbe.periodSeconds}")" = "2" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath="$c.startupProbe.httpGet.path}")" = "/alive" ] || exit 1
period=$(kubectl get deployment den-den -o jsonpath="$c.startupProbe.periodSeconds}")
failures=$(kubectl get deployment den-den -o jsonpath="$c.startupProbe.failureThreshold}")
[ $(( period * failures )) -ge 30 ] || exit 1
want=$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}')
[ "$(kubectl get deployment den-den -o jsonpath='{.status.updatedReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "$want" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "$want" ] || exit 1
for pod in $(kubectl get pods -l app=den-den -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}'); do
  [ "$(kubectl get pod "$pod" -o jsonpath='{.status.containerStatuses[0].restartCount}')" = "0" ] || exit 1
done
