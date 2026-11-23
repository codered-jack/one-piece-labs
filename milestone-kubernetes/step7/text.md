Remove the whole app. Deleting its namespace deletes everything in it: the Deployments, their pods, and the Services.

Then check:

`kubectl get namespaces`{{exec}}

`bounty-board` may say `Terminating` for a few seconds. The `port-forward` in the background stops by itself, once its pod is gone.

Press **Check** when it's gone or going.

<br>

<details><summary>Tip</summary>

`kubectl delete namespace <name>`.

</details>

<details><summary>Solution</summary>

```plain
kubectl delete namespace bounty-board
kubectl get namespaces
```{{exec}}

</details>
