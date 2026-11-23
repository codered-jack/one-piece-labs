#!/bin/bash
# Passes when the watchtower pod has two ready containers, and the lookout
# container has printed the Den Den Mushi's answer.
[ "$(kubectl get pod watchtower -o jsonpath='{.status.containerStatuses[*].ready}' 2>/dev/null)" = "true true" ] || exit 1
kubectl logs watchtower -c lookout 2>/dev/null | grep -qx 'Purupurupuru! watchtower here.'
