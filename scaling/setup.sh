#!/bin/bash
# Writes the den-den Deployment from the Deployments lab to ~/fleet, and
# applies it, so the lab starts with three copies running.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
mkdir -p /root/fleet
cat > /root/fleet/den-den-deployment.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: den-den
spec:
  replicas: 3
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
          image: python:3.12-alpine
          command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && python3 -m http.server 8000"]
          ports:
            - containerPort: 8000
EOF
kubectl apply -f /root/fleet/den-den-deployment.yaml
