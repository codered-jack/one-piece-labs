#!/bin/bash
# Passes when ~/fleet/navigator.yaml has the right image, and the navigator
# Deployment has its one copy ready.
grep -q 'image: python:3.13-alpine' /root/fleet/navigator.yaml 2>/dev/null || exit 1
[ "$(kubectl get deployment navigator -o jsonpath='{.status.readyReplicas}' 2>/dev/null)" = "1" ]
