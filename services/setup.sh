#!/bin/bash
# Starts the lab's cast: the den-den Deployment (three copies), a lookout pod to
# call from, and the Service lookout-line, whose selector has a typo on
# purpose. Step 5 asks the learner to fix it.
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
cat > /root/fleet/lookout-line.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: lookout-line
spec:
  selector:
    app: den-dem
  ports:
    - port: 80
      targetPort: 8000
EOF
kubectl apply -f /root/fleet/den-den-deployment.yaml
kubectl apply -f /root/fleet/lookout-line.yaml
kubectl apply -f - <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: lookout
spec:
  terminationGracePeriodSeconds: 1
  containers:
    - name: lookout
      image: alpine
      command: ["sleep", "100000"]
EOF
