#!/bin/bash
# Passes when ~/node.txt holds the name of the cluster's node.
node=$(kubectl get nodes -o jsonpath='{.items[0].metadata.name}')
[ -n "$node" ] || exit 1
[ "$(tr -d '[:space:]' < /root/node.txt 2>/dev/null)" = "$node" ]
