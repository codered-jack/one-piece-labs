#!/bin/bash
# Passes when ~/fleet/db-data.yaml exists, and the claim db-data asks for 1Gi,
# ReadWriteOnce.
grep -q "kind: PersistentVolumeClaim" /root/fleet/db-data.yaml 2>/dev/null || exit 1
[ "$(kubectl get pvc db-data -o jsonpath='{.spec.resources.requests.storage}' 2>/dev/null)" = "1Gi" ] || exit 1
[ "$(kubectl get pvc db-data -o jsonpath='{.spec.accessModes[*]}')" = "ReadWriteOnce" ]
