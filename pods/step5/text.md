Delete both pods. One command can delete several: list their names one after the other.

Deleting takes about 30 seconds. Kubernetes asks each app to stop, and waits up to 30 seconds before killing it. `--now` skips most of the wait.

Then check that they're gone, and that nothing brought them back:

`kubectl get pods`{{exec}}

Press **Check** when both are gone.

<br>

<details><summary>Tip</summary>

`kubectl delete pod` takes one or more pod names.

</details>

<details><summary>Solution</summary>

```plain
kubectl delete pod den-den watchtower --now
```{{exec}}

</details>
