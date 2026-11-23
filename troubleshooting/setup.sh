#!/bin/bash
# Writes four broken things to ~/fleet and applies them, for the learner to
# fix: an image typo (navigator), a command typo that crashes (cook), a
# nodeSelector no node matches (shipwright), and a Service on the wrong
# targetPort (den-den). Also starts a lookout pod to make calls from.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
mkdir -p /root/fleet
cat > /root/fleet/navigator.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: navigator
spec:
  replicas: 1
  selector:
    matchLabels:
      app: navigator
  template:
    metadata:
      labels:
        app: navigator
    spec:
      containers:
        - name: navigator
          image: python:3.13-alpien
          command: ["python3", "-m", "http.server", "8000"]
EOF
cat > /root/fleet/cook.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cook
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cook
  template:
    metadata:
      labels:
        app: cook
    spec:
      containers:
        - name: cook
          image: python:3.13-alpine
          command: ["sh", "-c", "echo 'Lighting the stove...' && pythn3 -m http.server 8000"]
EOF
cat > /root/fleet/shipwright.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: shipwright
spec:
  replicas: 1
  selector:
    matchLabels:
      app: shipwright
  template:
    metadata:
      labels:
        app: shipwright
    spec:
      nodeSelector:
        island: water-seven
      containers:
        - name: shipwright
          image: alpine
          command: ["sleep", "100000"]
EOF
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
      targetPort: 8080
EOF
kubectl apply -f /root/fleet/
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
