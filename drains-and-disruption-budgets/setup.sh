#!/bin/bash
# Writes and applies four copies of the Den Den Mushi (readiness probe, quick
# stop) and its Service, and pins the lookout pod to the control plane so
# drains of node01 never touch it.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
kubectl wait --for=condition=Ready node --all --timeout=180s
mkdir -p /root/fleet
cat > /root/fleet/den-den-deployment.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: den-den
spec:
  replicas: 4
  selector:
    matchLabels:
      app: den-den
  template:
    metadata:
      labels:
        app: den-den
    spec:
      terminationGracePeriodSeconds: 1
      containers:
        - name: den-den
          image: python:3.13-alpine
          command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && touch ready && sleep 10 && python3 -m http.server 8000"]
          readinessProbe:
            httpGet:
              path: /ready
              port: 8000
            periodSeconds: 2
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
cat > /root/fleet/lookout.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: lookout
spec:
  nodeName: controlplane
  containers:
    - name: lookout
      image: alpine
      command: ["sleep", "100000"]
EOF
kubectl apply -f /root/fleet/den-den-deployment.yaml
kubectl apply -f /root/fleet/den-den-service.yaml
kubectl apply -f /root/fleet/lookout.yaml
