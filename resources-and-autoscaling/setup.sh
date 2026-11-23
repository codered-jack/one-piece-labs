#!/bin/bash
# Installs metrics-server (kubeadm's kubelet certificates don't list the node's
# IP, so it needs --kubelet-insecure-tls), writes and applies the Den Den
# Mushi's Deployment (no resources yet) and Service, and writes hungry.yaml,
# a pod that takes 100 MiB, with no limit yet. hungry isn't applied.
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
          command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && python3 -m http.server 8000"]
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
cat > /root/fleet/hungry.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: hungry
spec:
  containers:
    - name: hungry
      image: python:3.13-alpine
      command: ["python3", "-c", "b = bytearray(100 * 1024 * 1024); import time; time.sleep(3600)"]
EOF
kubectl apply -f /root/fleet/den-den-deployment.yaml
kubectl apply -f /root/fleet/den-den-service.yaml
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.9.1/components.yaml
kubectl get deployment metrics-server -n kube-system -o jsonpath='{.spec.template.spec.containers[0].args}' | grep -q kubelet-insecure-tls ||
  kubectl patch deployment metrics-server -n kube-system --type=json -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
