First, wait for the setup to finish. This prints `ready` when it has:

`until [ -f ~/.setup-done ]; do sleep 2; done; echo ready`{{exec}}

The board is up, with no probes yet:

`cd ~/one-piece-labs/bounty-board; kubectl get pods -n bounty-board`{{exec}}

Add a readiness probe to each part's container, under `ports:`, in the files in `final/`:

| File | Probe | Every |
|---|---|---|
| `api.yaml` | `httpGet:` `/api/health`, port 8000 | 5 seconds |
| `web.yaml` | `httpGet:` `/`, port 80 | 5 seconds |
| `cache.yaml` | `exec:` `["redis-cli", "ping"]` | 5 seconds |
| `db.yaml` | `exec:` `["pg_isready", "-U", "bounty"]` | 5 seconds |

Give the API a liveness probe too: `tcpSocket:` on port 8000, with the defaults. Then apply the folder:

`kubectl apply -n bounty-board -f final/`{{exec}}

Press **Check** when every part is ready again.

<br>

<details><summary>Tip</summary>

"Every 5 seconds" is `periodSeconds: 5`. The API's `/api/health` checks the database and the cache, so it belongs in the readiness probe, not the liveness probe. Watch the pods with `kubectl get pods -n bounty-board -w`, and press Ctrl+C to stop.

</details>

<details><summary>Solution</summary>

```plain
cd ~/one-piece-labs/bounty-board
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
          readinessProbe:
            httpGet:
              path: /api/health
              port: 8000
            periodSeconds: 5
          livenessProbe:
            tcpSocket:
              port: 8000
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
cat > final/web.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web
spec:
  replicas: 2
  selector:
    matchLabels:
      app: web
  template:
    metadata:
      labels:
        app: web
    spec:
      containers:
        - name: web
          image: bounty-board-web:1.0
          ports:
            - containerPort: 80
          readinessProbe:
            httpGet:
              path: /
              port: 80
            periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: web
spec:
  selector:
    app: web
  ports:
    - port: 80
      targetPort: 80
EOF
cat > final/cache.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: cache
spec:
  replicas: 1
  selector:
    matchLabels:
      app: cache
  template:
    metadata:
      labels:
        app: cache
    spec:
      containers:
        - name: cache
          image: redis:8-alpine
          ports:
            - containerPort: 6379
          readinessProbe:
            exec:
              command: ["redis-cli", "ping"]
            periodSeconds: 5
---
apiVersion: v1
kind: Service
metadata:
  name: cache
spec:
  selector:
    app: cache
  ports:
    - port: 6379
      targetPort: 6379
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
          readinessProbe:
            exec:
              command: ["pg_isready", "-U", "bounty"]
            periodSeconds: 5
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
kubectl apply -n bounty-board -f final/
kubectl rollout status -n bounty-board statefulset/db
kubectl rollout status -n bounty-board deployment/api
kubectl rollout status -n bounty-board deployment/web
kubectl rollout status -n bounty-board deployment/cache
```{{exec}}

</details>
