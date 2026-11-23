The API reads one setting for the database, `DATABASE_URL`. In the milestone's `api.yaml`, the password is written inside it. Look:

`grep -n "not-a-real-secret" final/api.yaml`{{exec}}

Change `final/api.yaml` so Kubernetes builds `DATABASE_URL` for you:

- take every setting from the ConfigMap `db-settings`
- add `DB_PASSWORD`, from the Secret `db-password`
- set `DATABASE_URL` to `postgresql://$(POSTGRES_USER):$(DB_PASSWORD)@db:5432/$(POSTGRES_DB)`

Keep `REDIS_HOST: cache`. Then apply the API, with `web.yaml` and `cache.yaml` unchanged. Check what the API got:

`kubectl exec -n bounty-board deployment/api -- printenv DATABASE_URL`{{exec}}

`grep -rn "not-a-real-secret" final/`{{exec}}

Press **Check** when the API is up, and no file in `final/` holds the password.

<br>

<details><summary>Tip</summary>

`$(NAME)` works only for a variable from `envFrom:`, or from earlier in the `env:` list. So put `DB_PASSWORD` above `DATABASE_URL`. Apply all three files at once with `kubectl apply -n bounty-board -f final/api.yaml -f final/web.yaml -f final/cache.yaml`.

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
kubectl apply -n bounty-board -f final/api.yaml -f final/web.yaml -f final/cache.yaml
kubectl rollout status -n bounty-board deployment/api
kubectl rollout status -n bounty-board deployment/web
kubectl rollout status -n bounty-board deployment/cache
kubectl exec -n bounty-board deployment/api -- printenv DATABASE_URL
```{{exec}}

</details>
