#!/bin/bash
# Passes when a pod the den-den ReplicaSet made has lost its app label, and
# the Deployment has 3 copies ready alongside it. ReplicaSet pods keep their
# pod-template-hash label, so that label finds the stray pod.
[ -n "$(kubectl get pods -l 'pod-template-hash,!app' -o name)" ] || exit 1
[ "$(kubectl get deployment den-den -o jsonpath='{.status.readyReplicas}')" = "3" ]
