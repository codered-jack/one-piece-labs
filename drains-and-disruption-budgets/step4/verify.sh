#!/bin/bash
# Passes when the den-den budget keeps at least 3 app=den-den pods, node01 is
# cordoned with no den-den pod left on it, and all four copies are ready.
[ "$(kubectl get pdb den-den -o jsonpath='{.spec.minAvailable}' 2>/dev/null)" = "3" ] || exit 1
[ "$(kubectl get pdb den-den -o jsonpath='{.spec.selector.matchLabels.app}')" = "den-den" ] || exit 1
[ "$(kubectl get node node01 -o jsonpath='{.spec.unschedulable}')" = "true" ] || exit 1
pods_there=$(kubectl get pods -l app=den-den --field-selector spec.nodeName=node01 -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}')
[ -z "$pods_there" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "4" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.replicas}')" = "4" ]
