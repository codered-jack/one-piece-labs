#!/bin/bash
# Passes when the lookout pod, still the one the setup started, has
# sea=grand-line.
[ "$(kubectl get pod lookout -o jsonpath='{.metadata.labels.sea}' 2>/dev/null)" = "grand-line" ] || exit 1
[ "$(kubectl get pod lookout -o jsonpath='{.metadata.labels.app}')" = "lookout" ]
