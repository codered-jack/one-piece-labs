Replace `final/db.yaml` with two objects:

- a headless Service named `db`, on port 5432, for the pods labeled `app: db`
- a StatefulSet named `db`, with one copy of the image `bounty-board-db:1.0`

The StatefulSet's container takes its settings from the ConfigMap `db-settings`, and `POSTGRES_PASSWORD` from the Secret `db-password`. It keeps its data in `/var/lib/postgresql/data`, on a 1Gi disk from a claim template named `data`.

Apply it, and wait for `db-0`:

`kubectl rollout status -n bounty-board statefulset/db`{{exec}}

`kubectl get pods,pvc -n bounty-board`{{exec}}

Press **Check** when `db-0` is ready, and the claim `data-db-0` is `Bound`.

<br>

<details><summary>Tip</summary>

Headless means `clusterIP: None`. The StatefulSet needs `serviceName: db`. In the container, `envFrom:` with `configMapRef:` takes the settings, and `env:` with `secretKeyRef:` takes the password. `volumeClaimTemplates:` goes under the StatefulSet's `spec:`, beside `template:`.

</details>

<details><summary>Solution</summary>

```plain
cd ~/one-piece-labs/bounty-board
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
kubectl apply -n bounty-board -f final/db.yaml
kubectl rollout status -n bounty-board statefulset/db
kubectl get pods,pvc -n bounty-board
```{{exec}}

</details>
