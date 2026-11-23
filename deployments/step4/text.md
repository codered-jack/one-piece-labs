The ReplicaSet counts pods by their `app` label. Remove that label from one pod, then list the pods with the label as a column:

`kubectl get pods -L app`{{exec}}

There are four pods now. The one without a label still runs, but the ReplicaSet no longer counts it, so it made a new one.

Press **Check** when there's a pod without the `app` label, and three with it.

<br>

<details><summary>Tip</summary>

`kubectl label pod <name> app-` removes the `app` label. The `-` after the key means remove.

</details>

<details><summary>Solution</summary>

```plain
POD=$(kubectl get pods -l app=den-den -o jsonpath='{.items[0].metadata.name}')
kubectl label pod "$POD" app-
kubectl get pods -L app
```{{exec}}

</details>
