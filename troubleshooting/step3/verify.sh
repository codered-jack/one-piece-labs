#!/bin/bash
# Passes when the shipwright Deployment has its one copy ready, whether the
# node was labelled or the nodeSelector was removed.
[ "$(kubectl get deployment shipwright -o jsonpath='{.status.readyReplicas}' 2>/dev/null)" = "1" ]
