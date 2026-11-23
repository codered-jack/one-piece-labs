Postgres keeps its data in `/var/lib/postgresql/data`. Change `~/fleet/db.yaml` so that folder is the claim `db-data`. Then start the pod, and wait for it:

`kubectl wait --for=condition=Ready pod/db --timeout=90s`{{exec}}

The claim has its disk now. A **PersistentVolume** is the disk itself:

`kubectl get pvc,pv`{{exec}}

Press **Check** when Postgres runs on the claim.

<br>

<details><summary>Tip</summary>

The pod needs `volumes:`, next to `containers:`: a list with one item, a `name:` and `persistentVolumeClaim:` with `claimName: db-data`. The container needs `volumeMounts:`, with the same `name:` and a `mountPath:`.

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
      volumeMounts:
        - name: data
          mountPath: /var/lib/postgresql/data
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: db-data
EOF
kubectl apply -f ~/fleet/db.yaml
kubectl wait --for=condition=Ready pod/db --timeout=90s
kubectl get pvc,pv
```{{exec}}

</details>
