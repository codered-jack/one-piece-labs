#!/bin/bash
# Passes when the den-den Deployment still exists and asks for 0 copies.
[ "$(kubectl get deployment den-den -o jsonpath='{.spec.replicas}' 2>/dev/null)" = "0" ]
