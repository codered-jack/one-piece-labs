See where the four copies run. The `NODE` column shows each one's node:

`kubectl get pods -o wide`{{exec}}

Close `node01` to new pods, so the scheduler stops putting pods there. The copies already on it keep running. Then list the nodes: `node01` should say `SchedulingDisabled`.

`kubectl get nodes`{{exec}}

Press **Check** when `node01` is closed.

<br>

<details><summary>Tip</summary>

`kubectl cordon <node name>` closes a node to new pods.

</details>

<details><summary>Solution</summary>

```plain
kubectl cordon node01
kubectl get nodes
```{{exec}}

</details>
