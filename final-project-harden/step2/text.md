See what each part really uses:

`kubectl top pods -n bounty-board`{{exec}}

Give each container a `resources:` block, under its probe. Requests for CPU and memory, and a limit for memory only:

| File | CPU request | Memory request | Memory limit |
|---|---|---|---|
| `api.yaml` | `50m` | `96Mi` | `192Mi` |
| `web.yaml` | `10m` | `16Mi` | `64Mi` |
| `cache.yaml` | `10m` | `32Mi` | `128Mi` |
| `db.yaml` | `50m` | `64Mi` | `256Mi` |

Apply the folder, and check one API pod:

`kubectl apply -n bounty-board -f final/`{{exec}}

`kubectl describe pod -n bounty-board -l app=api | grep -E -A3 'Limits:|Requests:'`{{exec}}

Press **Check** when every part has its requests and limit, and is ready.

<br>

<details><summary>Tip</summary>

The block looks like this, for the API:

```plain
          resources:
            requests:
              cpu: 50m
              memory: 96Mi
            limits:
              memory: 192Mi
```

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
          resources:
            requests:
              cpu: 50m
              memory: 96Mi
            limits:
              memory: 192Mi
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
          resources:
            requests:
              cpu: 10m
              memory: 16Mi
            limits:
              memory: 64Mi
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
          resources:
            requests:
              cpu: 10m
              memory: 32Mi
            limits:
              memory: 128Mi
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
          resources:
            requests:
              cpu: 50m
              memory: 64Mi
            limits:
              memory: 256Mi
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
