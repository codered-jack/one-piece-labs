#!/bin/bash
# Passes when the db pod takes POSTGRES_PASSWORD from the Secret db-password,
# and Postgres accepts that password over the network. Connecting to the pod's
# own address, not 127.0.0.1, makes Postgres check the password.
ref=$(kubectl get pod db -o jsonpath='{range .spec.containers[0].env[?(@.name=="POSTGRES_PASSWORD")]}{.valueFrom.secretKeyRef.name}/{.valueFrom.secretKeyRef.key}{end}' 2>/dev/null)
[ "$ref" = "db-password/password" ] || exit 1
kubectl exec db -- sh -c 'PGPASSWORD=not-a-real-secret psql -h "$(hostname -i)" -U postgres -tAc "SELECT 1"' 2>/dev/null | grep -qx 1
