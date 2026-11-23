#!/bin/bash
# Passes when the db pod is ready, keeps /var/lib/postgresql/data on the claim
# db-data, and the claim is Bound.
[ "$(kubectl get pod db -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}' 2>/dev/null)" = "True" ] || exit 1
volume=$(kubectl get pod db -o jsonpath='{range .spec.volumes[?(@.persistentVolumeClaim.claimName=="db-data")]}{.name}{end}')
[ -n "$volume" ] || exit 1
[ "$(kubectl get pod db -o jsonpath="{.spec.containers[0].volumeMounts[?(@.name==\"$volume\")].mountPath}")" = "/var/lib/postgresql/data" ] || exit 1
[ "$(kubectl get pvc db-data -o jsonpath='{.status.phase}')" = "Bound" ]
