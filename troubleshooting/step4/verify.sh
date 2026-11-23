#!/bin/bash
# Passes when ~/fleet/den-den-service.yaml targets port 8000, and a call to the
# den-den Service from the lookout reaches the Den Den Mushi.
grep -Eq '^[[:space:]]*targetPort:[[:space:]]*8000[[:space:]]*$' /root/fleet/den-den-service.yaml 2>/dev/null || exit 1
kubectl exec lookout -- wget -qO- -T 3 http://den-den 2>/dev/null | grep -q '^Purupurupuru! den-den-'
