#!/bin/bash
# Passes when node01 is cordoned.
[ "$(kubectl get node node01 -o jsonpath='{.spec.unschedulable}' 2>/dev/null)" = "true" ]
