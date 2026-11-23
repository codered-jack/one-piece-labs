Write `~/fleet/db-data.yaml`: a PersistentVolumeClaim named `db-data`, asking for **1Gi**, for one machine at a time to read and write. Apply it, and look at it:

`kubectl get pvc`{{exec}}

It says `Pending`. See why, at the end of:

`kubectl describe pvc db-data`{{exec}}

The disk is made only once a pod uses the claim. This cluster's storage class says so:

`kubectl get storageclass`{{exec}}

Press **Check** when the claim is there.

<br>

<details><summary>Tip</summary>

A claim starts with `apiVersion: v1` and `kind: PersistentVolumeClaim`. Under `spec:` go `accessModes:`, a list with `ReadWriteOnce`, and `resources:`, with `requests:` and `storage: 1Gi`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/db-data.yaml <<'EOF'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: db-data
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
EOF
kubectl apply -f ~/fleet/db-data.yaml
kubectl get pvc
```{{exec}}

</details>
