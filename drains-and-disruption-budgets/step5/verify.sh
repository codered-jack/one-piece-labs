#!/bin/bash
# Passes when the den-den budget requires all 4 copies, and ~/blocked.txt holds
# the eviction refusal from a drain.
[ "$(kubectl get pdb den-den -o jsonpath='{.spec.minAvailable}' 2>/dev/null)" = "4" ] || exit 1
grep -q "violate the pod's disruption budget" /root/blocked.txt 2>/dev/null
