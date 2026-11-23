#!/bin/bash
# Installs the Gateway API CRDs and NGINX Gateway Fabric, starts three apps
# (den-den, wanted, logbook) with their Services and the lookout pod, and
# writes a logbook route whose backend name is wrong, for step 5. The route
# is not applied.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.7.0/standard-install.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.9.0/deploy/crds.yaml
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.9.0/deploy/default/deploy.yaml
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
cat > /root/fleet/wanted.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: wanted
spec:
  replicas: 2
  selector:
    matchLabels:
      app: wanted
  template:
    metadata:
      labels:
        app: wanted
    spec:
      containers:
        - name: wanted
          image: python:3.13-alpine
          command: ["sh", "-c", "mkdir wanted && echo \"WANTED: Monkey D. Luffy, 3,000,000,000 berries. Posted by $(hostname).\" > wanted/index.html && python3 -m http.server 8000"]
          ports:
            - containerPort: 8000
---
apiVersion: v1
kind: Service
metadata:
  name: wanted
spec:
  selector:
    app: wanted
  ports:
    - port: 80
      targetPort: 8000
EOF
cat > /root/fleet/logbook.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: logbook
spec:
  replicas: 1
  selector:
    matchLabels:
      app: logbook
  template:
    metadata:
      labels:
        app: logbook
    spec:
      containers:
        - name: logbook
          image: python:3.13-alpine
          command: ["sh", "-c", "mkdir logbook && echo \"Logbook: Log Pose set for the next island. Written by $(hostname).\" > logbook/index.html && python3 -m http.server 8000"]
          ports:
            - containerPort: 8000
---
apiVersion: v1
kind: Service
metadata:
  name: logbook
spec:
  selector:
    app: logbook
  ports:
    - port: 80
      targetPort: 8000
EOF
cat > /root/fleet/logbook-route.yaml <<'EOF'
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: logbook
spec:
  parentRefs:
    - name: front-door
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /logbook
      backendRefs:
        - name: log-book
          port: 80
EOF
kubectl apply -f /root/fleet/den-den-deployment.yaml -f /root/fleet/den-den-service.yaml -f /root/fleet/wanted.yaml -f /root/fleet/logbook.yaml
kubectl run lookout --image=alpine -- sleep 100000
kubectl rollout status deployment/nginx-gateway -n nginx-gateway --timeout=300s
