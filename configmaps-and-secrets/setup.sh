#!/bin/bash
# Writes the Den Den Mushi's Deployment, which reads $SHIP but isn't given it
# yet, and applies it. Also writes db.yaml, a Postgres pod with no password,
# for step 5. It isn't applied.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
mkdir -p /root/fleet
cat > /root/fleet/den-den-deployment.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: den-den
spec:
  replicas: 2
  selector:
    matchLabels:
      app: den-den
  template:
    metadata:
      labels:
        app: den-den
    spec:
      containers:
        - name: den-den
          image: python:3.13-alpine
          command: ["sh", "-c", "echo \"Purupurupuru! The $SHIP calling. $(hostname) here.\" > index.html && python3 -m http.server 8000"]
          ports:
            - containerPort: 8000
EOF
cat > /root/fleet/db.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: db
spec:
  containers:
    - name: db
      image: postgres:17-alpine
EOF
kubectl apply -f /root/fleet/den-den-deployment.yaml
