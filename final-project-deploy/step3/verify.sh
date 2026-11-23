#!/bin/bash
# Passes when db runs as a ready StatefulSet behind a headless Service, takes
# its settings from db-settings and its password from db-password (and holds
# no password of its own), and its claim data-db-0 is bound.
ns="-n bounty-board"
s="kubectl get statefulset db $ns -o jsonpath"
[ "$($s='{.status.readyReplicas}' 2>/dev/null)" = "1" ] || exit 1
[ "$(kubectl get service db $ns -o jsonpath='{.spec.clusterIP}')" = "None" ] || exit 1
$s='{.spec.template.spec.containers[0].envFrom[*].configMapRef.name}' | grep -qw db-settings || exit 1
[ "$($s='{.spec.template.spec.containers[0].env[?(@.name=="POSTGRES_PASSWORD")].valueFrom.secretKeyRef.name}')" = "db-password" ] || exit 1
kubectl get statefulset db $ns -o yaml | grep -q "not-a-real-secret" && exit 1
[ "$(kubectl get pvc data-db-0 $ns -o jsonpath='{.status.phase}')" = "Bound" ]
