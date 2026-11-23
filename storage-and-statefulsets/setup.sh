#!/bin/bash
# Creates the Secret db-password from the ConfigMaps and Secrets lab, and
# writes db.yaml: Postgres with its password from that Secret, but no disk yet.
# Step 2 asks the learner to add one. Nothing is started.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
mkdir -p /root/fleet
kubectl create secret generic db-password --from-literal=password=not-a-real-secret
cat > /root/fleet/db.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: db
spec:
  containers:
    - name: db
      image: postgres:17-alpine
      env:
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-password
              key: password
EOF
