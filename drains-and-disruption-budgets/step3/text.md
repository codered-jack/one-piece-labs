The maintenance is done. Open `node01` to new pods again, and look at the pods:

`kubectl get pods -o wide`{{exec}}

All four copies stay on `controlplane`. Opening a node only lets new pods in. Running pods don't move back.

Get at least one copy back onto `node01`. A rolling restart replaces every copy, and the scheduler spreads the new ones over both nodes. Wait for it to finish:

`kubectl rollout status deployment/den-den`{{exec}}

`kubectl get pods -o wide`{{exec}}

Press **Check** when `node01` is open, and runs at least one ready Den Den Mushi.

<br>

<details><summary>Tip</summary>

`kubectl uncordon <node name>` opens a node again. `kubectl rollout restart deployment/den-den` replaces every copy, one by one.

</details>

<details><summary>Solution</summary>

```plain
kubectl uncordon node01
kubectl rollout restart deployment/den-den
kubectl rollout status deployment/den-den
kubectl get pods -o wide
```{{exec}}

</details>
