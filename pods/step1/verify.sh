#!/bin/bash
# Passes when ~/fleet/den-den.yaml exists, and the den-den pod is running
# python:3.12-alpine, notes port 8000, and answers with its own name.
[ -f /root/fleet/den-den.yaml ] || exit 1
[ "$(kubectl get pod den-den -o jsonpath='{.status.phase}' 2>/dev/null)" = "Running" ] || exit 1
[ "$(kubectl get pod den-den -o jsonpath='{.spec.containers[0].image}')" = "python:3.12-alpine" ] || exit 1
[ "$(kubectl get pod den-den -o jsonpath='{.spec.containers[0].ports[0].containerPort}')" = "8000" ] || exit 1
[ "$(kubectl exec den-den -- wget -qO- http://127.0.0.1:8000 2>/dev/null)" = "Purupurupuru! den-den here." ]
