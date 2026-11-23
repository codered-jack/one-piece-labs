#!/bin/bash
# Passes when the Service db is headless, the StatefulSet db has its one copy
# ready, and db-0's own claim is Bound.
[ "$(kubectl get service db -o jsonpath='{.spec.clusterIP}' 2>/dev/null)" = "None" ] || exit 1
[ "$(kubectl get statefulset db -o jsonpath='{.spec.serviceName}' 2>/dev/null)" = "db" ] || exit 1
[ "$(kubectl get statefulset db -o jsonpath='{.status.readyReplicas}')" = "1" ] || exit 1
template=$(kubectl get statefulset db -o jsonpath='{.spec.volumeClaimTemplates[0].metadata.name}')
[ -n "$template" ] || exit 1
[ "$(kubectl get pvc "$template-db-0" -o jsonpath='{.status.phase}' 2>/dev/null)" = "Bound" ]
