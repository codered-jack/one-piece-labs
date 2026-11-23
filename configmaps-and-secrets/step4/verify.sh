#!/bin/bash
# Passes when the Secret db-password holds password=not-a-real-secret.
value=$(kubectl get secret db-password -o jsonpath='{.data.password}' 2>/dev/null | base64 -d 2>/dev/null)
[ "$value" = "not-a-real-secret" ]
