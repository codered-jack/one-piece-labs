#!/bin/bash
# Writes and applies the slow-starting Den Den Mushi (no probes yet) and its
# Service, and starts the lookout pod to call it from.
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
          image: python:3.13-alpine
          command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && touch ready alive && sleep 10 && python3 -m http.server 8000"]
          ports:
            - containerPort: 8000
EOF
cat > /root/fleet/den-den-service.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: den-den
spec:
  selector:
    app: den-den
  ports:
    - port: 80
      targetPort: 8000
EOF
kubectl apply -f /root/fleet/den-den-deployment.yaml
kubectl apply -f /root/fleet/den-den-service.yaml
kubectl run lookout --image=alpine -- sleep 100000
