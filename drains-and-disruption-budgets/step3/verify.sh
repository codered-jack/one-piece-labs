#!/bin/bash
# Passes when node01 is open again, at least one den-den pod runs there, and
# all four copies are ready with the rollout finished.
[ -z "$(kubectl get node node01 -o jsonpath='{.spec.unschedulable}' 2>/dev/null)" ] || exit 1
pods_there=$(kubectl get pods -l app=den-den --field-selector spec.nodeName=node01 -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}')
[ -n "$pods_there" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "4" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.updatedReplicas}')" = "4" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "4" ]
