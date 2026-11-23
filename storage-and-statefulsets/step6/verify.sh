#!/bin/bash
# Passes when the StatefulSet db is gone, and db-0's claim is still there.
kubectl get statefulset db >/dev/null 2>&1 && exit 1
kubectl get pvc -o name 2>/dev/null | grep -q -- "-db-0$"
