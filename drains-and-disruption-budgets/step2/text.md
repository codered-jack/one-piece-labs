Move every Den Den Mushi off `node01` by draining it. A drain evicts each pod on the node, and the Deployment makes replacements on `controlplane`.

The drain will refuse to remove the network pods that run on every node. Tell it to leave them where they are. Then wait until all four copies are ready again:

`kubectl rollout status deployment/den-den`{{exec}}

`kubectl get pods -o wide`{{exec}}

Press **Check** when no Den Den Mushi runs on `node01`, and all four are ready.

<br>

<details><summary>Tip</summary>

`kubectl drain <node name> --ignore-daemonsets` drains a node, and leaves its DaemonSet pods alone. If it also complains about local storage, add `--delete-emptydir-data`.

</details>

<details><summary>Solution</summary>

```plain
kubectl drain node01 --ignore-daemonsets
kubectl rollout status deployment/den-den
kubectl get pods -o wide
```{{exec}}

</details>
