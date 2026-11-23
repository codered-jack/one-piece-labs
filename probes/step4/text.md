Make one Den Den Mushi fail its liveness probe: delete its `alive` file. Then watch the pods. Press Ctrl+C to stop watching:

`kubectl get pods -l app=den-den -w`{{exec}}

Three failed checks take about 5 seconds. Then the node asks the app to stop, and waits up to 30 seconds before it kills it. So expect the restart after about 35 seconds. `RESTARTS` goes to `1`, and the pod is ready again 10 seconds later.

Press **Check** once it has restarted.

<br>

<details><summary>Tip</summary>

As in the last step, but delete `alive` instead of `ready`: `kubectl exec <pod name> -- rm alive`.

</details>

<details><summary>Solution</summary>

```plain
P=$(kubectl get pods -l app=den-den -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}' | awk '{print $1}')
kubectl exec "$P" -- rm alive
kubectl wait pod "$P" --for=jsonpath='{.status.containerStatuses[0].restartCount}'=1 --timeout=120s
kubectl get pods -l app=den-den
```{{exec}}

</details>
