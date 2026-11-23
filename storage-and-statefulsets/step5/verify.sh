#!/bin/bash
# Passes when Robin is in db-0's database, and db-0 found the data already
# there when it started, so it's a new db-0 on the old disk.
kubectl logs db-0 2>/dev/null | grep -q "Skipping initialization" || exit 1
kubectl exec db-0 -- psql -U postgres -tAc "SELECT name FROM bounties" 2>/dev/null | grep -qx "Nico Robin"
