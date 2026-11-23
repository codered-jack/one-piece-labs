#!/bin/bash
# Passes when ~/fleet/den-den-grand.yaml exists, and the den-den-grand pod has
# app=den-den and sea=grand-line.
[ -f /root/fleet/den-den-grand.yaml ] || exit 1
[ "$(kubectl get pod den-den-grand -o jsonpath='{.metadata.labels.app}' 2>/dev/null)" = "den-den" ] || exit 1
[ "$(kubectl get pod den-den-grand -o jsonpath='{.metadata.labels.sea}')" = "grand-line" ]
