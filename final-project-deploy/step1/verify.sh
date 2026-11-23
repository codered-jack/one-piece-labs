#!/bin/bash
# Passes when the Secret db-password in bounty-board holds the practice
# password under the key password.
v=$(kubectl get secret db-password -n bounty-board -o jsonpath='{.data.password}' 2>/dev/null | base64 -d)
[ "$v" = "not-a-real-secret" ]
