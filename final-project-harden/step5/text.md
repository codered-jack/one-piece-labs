When a pod is told to stop, the front door hears about it a moment later. In that moment, it can still send the pod a call. Make the API wait 5 seconds before it stops: add a `preStop` hook to its container, above `resources:`:

```plain
          lifecycle:
            preStop:
              sleep:
                seconds: 5
```

Apply the folder, and wait for the API's new pods:

`kubectl apply -n bounty-board -f final/`{{exec}}

`kubectl rollout status -n bounty-board deployment/api`{{exec}}

Press **Check** when the API's pods have the pause.

<br>

<details><summary>Tip</summary>

`lifecycle:` lines up with `image:` and `resources:`. The pause counts towards the 30 seconds a pod gets to stop, so 5 seconds leaves the app plenty.

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
          lifecycle:
            preStop:
              sleep:
                seconds: 5
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
kubectl apply -n bounty-board -f final/
kubectl rollout status -n bounty-board deployment/api
```{{exec}}

</details>
