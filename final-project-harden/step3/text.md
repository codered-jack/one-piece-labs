Let an HPA pick the number of API copies. In `final/api.yaml`:

- delete the line `replicas: 2`
- add a HorizontalPodAutoscaler named `api`, after the Service, for the Deployment `api`
- keep 2 to 5 copies, and aim for 50% of the CPU request

Apply the folder, then wait a minute for the first measurement:

`kubectl apply -n bounty-board -f final/`{{exec}}

`kubectl get hpa -n bounty-board`{{exec}}

Press **Check** when `TARGETS` shows a number instead of `<unknown>`.

<br>

<details><summary>Tip</summary>

Start the HPA with `---` on its own line, then `apiVersion: autoscaling/v2`. Without `replicas:`, the Deployment drops to 1 copy for a moment, until the HPA brings it back to 2.

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
EOF
kubectl apply -n bounty-board -f final/
until kubectl get hpa api -n bounty-board -o jsonpath='{.status.currentMetrics[0].resource.current.averageUtilization}' | grep -q .; do sleep 5; done
kubectl get hpa -n bounty-board
```{{exec}}

</details>
