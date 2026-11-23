#!/bin/bash
# Passes when ~/fleet/cook.yaml runs python3, and the cook Deployment has its
# one copy ready on that command.
grep -q 'python3 -m http.server' /root/fleet/cook.yaml 2>/dev/null || exit 1
d() { kubectl get deployment cook -o jsonpath="$1" 2>/dev/null; }
d '{.spec.template.spec.containers[0].command}' | grep -q 'python3 -m http.server' || exit 1
[ "$(d '{.status.updatedReplicas}')" = "1" ] || exit 1
[ "$(d '{.status.readyReplicas}')" = "1" ]
