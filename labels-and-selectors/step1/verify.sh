#!/bin/bash
# Passes when the den-den-east pod exists with app=den-den and sea=east-blue.
[ "$(kubectl get pod den-den-east -o jsonpath='{.metadata.labels.app}' 2>/dev/null)" = "den-den" ] || exit 1
[ "$(kubectl get pod den-den-east -o jsonpath='{.metadata.labels.sea}')" = "east-blue" ]
