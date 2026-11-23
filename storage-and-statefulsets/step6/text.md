Delete the StatefulSet `db`, but not its file. Then look for its pod, and its claim:

`kubectl get pods -l app=db`{{exec}}

`kubectl get pvc`{{exec}}

The pod is gone, and `data-db-0` is still there. Deleting a StatefulSet keeps its disks, because data is usually worth more than tidying up. Apply the file again, and the new `db-0` would find Robin.

Press **Check** when the StatefulSet is gone, and its claim isn't.

<br>

<details><summary>Tip</summary>

`kubectl delete statefulset <name>` deletes only the StatefulSet, and its pods.

</details>

<details><summary>Solution</summary>

```plain
kubectl delete statefulset db
kubectl get pods -l app=db
kubectl get pvc
```{{exec}}

</details>
