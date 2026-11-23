#!/bin/bash
# Hides the pod for step 4: a namespace named cargo-hold, with one pod in it.
# The pod is given 1 second to stop, so deleting the namespace in step 5
# doesn't keep the learner waiting.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
kubectl create namespace cargo-hold
kubectl apply -n cargo-hold -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: stowaway
spec:
  terminationGracePeriodSeconds: 1
  containers:
    - name: stowaway
      image: alpine
      command: ["sleep", "100000"]
EOF
