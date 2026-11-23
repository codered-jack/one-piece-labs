#!/bin/bash
# Passes when the bounty-board namespace is gone, or on its way out.
phase=$(kubectl get namespace bounty-board -o jsonpath='{.status.phase}' 2>/dev/null)
[ -z "$phase" ] || [ "$phase" = "Terminating" ]
