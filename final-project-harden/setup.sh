#!/bin/bash
# Rebuilds the end of part 1: installs the Gateway API CRDs, NGINX Gateway
# Fabric and metrics-server (with --kubelet-insecure-tls, as kubeadm's kubelet
# certificates don't list the node's IP), clones the labs repository, builds
# and imports the three images, writes final/ as part 1 left it, creates the
# namespace and the Secret, applies final/, posts Nico Robin, and starts the
# lookout pod. Touches /root/.setup-done when all of it has finished.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.7.0/standard-install.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.9.0/deploy/crds.yaml
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.9.0/deploy/default/deploy.yaml
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/download/v0.9.1/components.yaml
kubectl get deployment metrics-server -n kube-system -o jsonpath='{.spec.template.spec.containers[0].args}' | grep -q kubelet-insecure-tls ||
  kubectl patch deployment metrics-server -n kube-system --type=json -p '[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]'
cd /root
git clone https://github.com/codered-jack/one-piece-labs
cd /root/one-piece-labs/bounty-board
docker build -t bounty-board-web:1.0 web
docker build -t bounty-board-api:1.0 api
docker build -t bounty-board-db:1.0 db
docker save bounty-board-web:1.0 bounty-board-api:1.0 bounty-board-db:1.0 | ctr -n k8s.io images import -
cp -r k8s final
cat > final/settings.yaml <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: db-settings
data:
  POSTGRES_USER: bounty
  POSTGRES_DB: bounties
EOF
cat > final/db.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: db
spec:
  clusterIP: None
  selector:
    app: db
  ports:
    - port: 5432
---
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: db
spec:
  serviceName: db
  replicas: 1
  selector:
    matchLabels:
      app: db
  template:
    metadata:
      labels:
        app: db
    spec:
      containers:
        - name: db
          image: bounty-board-db:1.0
          envFrom:
            - configMapRef:
                name: db-settings
          env:
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: db-password
                  key: password
          ports:
            - containerPort: 5432
          volumeMounts:
            - name: data
              mountPath: /var/lib/postgresql/data
  volumeClaimTemplates:
    - metadata:
        name: data
      spec:
        accessModes:
          - ReadWriteOnce
        resources:
          requests:
            storage: 1Gi
EOF
cat > final/api.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: api
spec:
  replicas: 2
  selector:
    matchLabels:
      app: api
  template:
    metadata:
      labels:
        app: api
    spec:
      containers:
        - name: api
          image: bounty-board-api:1.0
          envFrom:
            - configMapRef:
                name: db-settings
          env:
            - name: DB_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: db-password
                  key: password
            - name: DATABASE_URL
              value: "postgresql://$(POSTGRES_USER):$(DB_PASSWORD)@db:5432/$(POSTGRES_DB)"
            - name: REDIS_HOST
              value: cache
          ports:
            - containerPort: 8000
---
apiVersion: v1
kind: Service
metadata:
  name: api
spec:
  selector:
    app: api
  ports:
    - port: 8000
      targetPort: 8000
EOF
cat > final/front-door.yaml <<'EOF'
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: front-door
spec:
  gatewayClassName: nginx
  listeners:
    - name: http
      protocol: HTTP
      port: 80
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: bounty-board
spec:
  parentRefs:
    - name: front-door
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /api
      backendRefs:
        - name: api
          port: 8000
    - backendRefs:
        - name: web
          port: 80
EOF
kubectl rollout status deployment/nginx-gateway -n nginx-gateway --timeout=300s
kubectl create namespace bounty-board
kubectl create secret generic db-password -n bounty-board --from-literal=password=not-a-real-secret
kubectl apply -n bounty-board -f final/
kubectl rollout status -n bounty-board statefulset/db --timeout=300s
for d in api web cache; do kubectl rollout status -n bounty-board deployment/$d --timeout=300s; done
until kubectl exec -n bounty-board deploy/web -- wget -qO- -T 2 http://api:8000/api/health 2>/dev/null | grep -q '"database":"up"'; do sleep 2; done
kubectl exec -n bounty-board deploy/web -- wget -qO- --header 'Content-Type: application/json' --post-data '{"name": "Nico Robin", "bounty": 930000000}' http://api:8000/api/bounties
kubectl run lookout -n bounty-board --image=alpine -- sleep 100000
kubectl wait -n bounty-board --for=condition=Ready pod/lookout --timeout=120s
kubectl rollout status deployment/metrics-server -n kube-system --timeout=300s
touch /root/.setup-done
