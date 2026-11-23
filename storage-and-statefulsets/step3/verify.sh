#!/bin/bash
# Passes when Robin is in the db pod's database, and that pod found the data
# already there when it started, so it's a new pod on the old disk.
kubectl logs db 2>/dev/null | grep -q "Skipping initialization" || exit 1
kubectl exec db -- psql -U postgres -tAc "SELECT name FROM bounties" 2>/dev/null | grep -qx "Nico Robin"
