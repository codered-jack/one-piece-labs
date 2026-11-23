#!/bin/bash
# Passes when none of the Deployments or the Service from ~/fleet are left.
for d in navigator cook shipwright den-den; do
  ! kubectl get deployment "$d" >/dev/null 2>&1 || exit 1
done
! kubectl get service den-den >/dev/null 2>&1
