`~/fleet/db.yaml` starts Postgres, but gives it no password. Postgres reads its password from the variable `POSTGRES_PASSWORD`. Set it from the `password` key of the Secret `db-password`, and apply the file.

Wait until it's ready:

`kubectl wait --for=condition=Ready pod/db --timeout=90s`{{exec}}

Now try the password from another pod. Postgres trusts connections from inside its own container, so that wouldn't prove anything. First, a wrong one:

`IP=$(kubectl get pod db -o jsonpath='{.status.podIP}'); kubectl run psql --image=postgres:17-alpine --restart=Never --env=PGPASSWORD=wrong --command -- psql -h $IP -U postgres -c "SELECT current_user"`{{exec}}

`kubectl logs psql`{{exec}}

Give it a few seconds to start, then read its logs again if they're empty. You should see `password authentication failed`. Delete it, and try the real one:

`kubectl delete pod psql --now; kubectl run psql --image=postgres:17-alpine --restart=Never --env=PGPASSWORD=not-a-real-secret --command -- psql -h $IP -U postgres -c "SELECT current_user"`{{exec}}

`kubectl logs psql`{{exec}}

Press **Check** when Postgres runs with the password from the Secret.

<br>

<details><summary>Tip</summary>

Under the container, add `env:`: a list with one item. Its `name:` is `POSTGRES_PASSWORD`, and its `valueFrom:` holds `secretKeyRef:`, with the Secret's `name:` and the `key:`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/db.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: db
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
EOF
kubectl apply -f ~/fleet/db.yaml
kubectl wait --for=condition=Ready pod/db --timeout=90s
```{{exec}}

</details>
