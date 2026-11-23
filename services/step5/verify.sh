#!/bin/bash
# Passes when ~/fleet/lookout-line.yaml selects app: den-den, and a call to the
# lookout-line Service from the lookout reaches the Den Den Mushi.
grep -Eq '^[[:space:]]*app:[[:space:]]*den-den[[:space:]]*$' /root/fleet/lookout-line.yaml 2>/dev/null || exit 1
[ "$(kubectl get service lookout-line -o jsonpath='{.spec.selector.app}' 2>/dev/null)" = "den-den" ] || exit 1
kubectl exec lookout -- wget -qO- -T 3 http://lookout-line 2>/dev/null | grep -q '^Purupurupuru! den-den-'
