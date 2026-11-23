A drain shouldn't take the API or the page down. Add a PodDisruptionBudget at the end of two files:

- in `final/api.yaml`: named `api`, for the pods labelled `app: api`
- in `final/web.yaml`: named `web`, for the pods labelled `app: web`

Each one allows 1 copy to be missing: `maxUnavailable: 1`. Don't give the database a budget. Apply the folder:

`kubectl apply -n bounty-board -f final/`{{exec}}

`kubectl get pdb -n bounty-board`{{exec}}

Press **Check** when both budgets allow 1 disruption.

<br>

<details><summary>Tip</summary>

`maxUnavailable: 1` keeps allowing 1, however many copies the HPA runs. The database has one copy, so any budget for it would either block every drain or protect nothing.

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
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: api
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: api
  minReplicas: 2
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: api
spec:
  maxUnavailable: 1
  selector:
    matchLabels:
      app: api
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
---
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: web
spec:
  maxUnavailable: 1
  selector:
    matchLabels:
      app: web
EOF
kubectl apply -n bounty-board -f final/
kubectl get pdb -n bounty-board
```{{exec}}

</details>
