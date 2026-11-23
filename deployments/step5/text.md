Deleting the Deployment's pods doesn't get rid of them: they come back. Delete the Deployment instead. It takes its ReplicaSet and its pods with it.

The pod you took ashore isn't the Deployment's any more, so delete it too.

Then check:

`kubectl get deployments,replicasets,pods`{{exec}}

The pods may say `Terminating` for up to 30 seconds. Press **Check** once the Deployment is gone, and every pod is gone or `Terminating`.

<br>

<details><summary>Tip</summary>

`kubectl delete deployment <name>` deletes a Deployment. `kubectl delete pod <name>` deletes the stray pod. `kubectl get pods -L app` shows which one it is.

</details>

<details><summary>Solution</summary>

`-l '!app'` picks the pods without an `app` label. Here, that's only the stray one.

```plain
kubectl delete deployment den-den
kubectl delete pods -l '!app' --now
kubectl get deployments,replicasets,pods
```{{exec}}

</details>
