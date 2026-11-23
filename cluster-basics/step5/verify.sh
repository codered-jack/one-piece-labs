#!/bin/bash
# Passes when the cargo-hold namespace is gone, or on its way out.
phase=$(kubectl get namespace cargo-hold -o jsonpath='{.status.phase}' 2>/dev/null)
[ -z "$phase" ] || [ "$phase" = "Terminating" ]
