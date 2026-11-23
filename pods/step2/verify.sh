#!/bin/bash
# Passes when ~/ip.txt holds the den-den pod's address.
ip=$(kubectl get pod den-den -o jsonpath='{.status.podIP}' 2>/dev/null)
[ -n "$ip" ] || exit 1
[ "$(tr -d '[:space:]' < /root/ip.txt 2>/dev/null)" = "$ip" ]
