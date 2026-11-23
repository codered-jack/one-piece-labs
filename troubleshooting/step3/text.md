Look at the `shipwright` pod:

`kubectl get pods -l app=shipwright`{{exec}}

It says `Pending`: no node has taken it. Ask why:

`kubectl describe pod -l app=shipwright`{{exec}}

Read the `FailedScheduling` event, and the `Node-Selectors` line above `Events`. Then fix it, either way:

- remove what the pod asks for from `~/fleet/shipwright.yaml`, and apply it
- or give the node what the pod asks for

Press **Check** when the shipwright is running.

<br>

<details><summary>Tip</summary>

The pod asks for a node labelled `island=water-seven`, and no node has that label. `kubectl get nodes --show-labels` lists the node's labels.

</details>

<details><summary>Solution</summary>

This gives every node the label. This cluster has one:

```plain
kubectl label nodes --all island=water-seven
kubectl rollout status deployment/shipwright
```{{exec}}

</details>
