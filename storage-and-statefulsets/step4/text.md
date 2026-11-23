Now run Postgres as a StatefulSet. Write `~/fleet/db-statefulset.yaml` with two parts, split by a line of `---`:

- a **headless** Service named `db`, on port **5432**, for the pods labelled `app: db`. Headless means `clusterIP: None`.
- a StatefulSet named `db`, with one copy. Its pods run the same container as `db.yaml`, and each gets its own **1Gi** claim, mounted at `/var/lib/postgresql/data`.

Apply it, and watch:

`kubectl get pods -l app=db`{{exec}}

`kubectl get pvc`{{exec}}

The pod is `db-0`, and its claim is `data-db-0`.

Press **Check** when `db-0` is ready.

<br>

<details><summary>Tip</summary>

A StatefulSet looks like a Deployment, with `kind: StatefulSet`, `serviceName: db`, and `volumeClaimTemplates:` instead of `volumes:`. Each template has a `metadata:` with a `name:`, and the claim's `spec:`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/db-statefulset.yaml <<'EOF'
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
          image: postgres:17-alpine
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
kubectl apply -f ~/fleet/db-statefulset.yaml
kubectl rollout status statefulset/db
kubectl get pods -l app=db
kubectl get pvc
```{{exec}}

</details>
