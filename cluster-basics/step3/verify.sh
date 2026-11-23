#!/bin/bash
# Passes when the grand-line namespace exists.
kubectl get namespace grand-line >/dev/null 2>&1
