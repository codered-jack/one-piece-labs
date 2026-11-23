#!/bin/bash
# Starts two labelled pods for the lab to pick out: a lookout and a cook, both
# in sea=east-blue. Each is given 1 second to stop, so deleting them is quick.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: lookout
  labels:
    app: lookout
    sea: east-blue
spec:
  terminationGracePeriodSeconds: 1
  containers:
    - name: lookout
      image: alpine
      command: ["sleep", "100000"]
---
apiVersion: v1
kind: Pod
metadata:
  name: cook
  labels:
    app: galley
    sea: east-blue
spec:
  terminationGracePeriodSeconds: 1
  containers:
    - name: cook
      image: alpine
      command: ["sleep", "100000"]
EOF
