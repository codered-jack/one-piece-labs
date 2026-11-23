#!/bin/bash
# Passes when node01 is cordoned, runs no den-den pod (terminating ones
# aside), and all four copies are ready elsewhere.
[ "$(kubectl get node node01 -o jsonpath='{.spec.unschedulable}' 2>/dev/null)" = "true" ] || exit 1
pods_there=$(kubectl get pods -l app=den-den --field-selector spec.nodeName=node01 -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}')
[ -z "$pods_there" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "4" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "4" ]
