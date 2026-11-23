Scale the Deployment to **0** copies. Then check what's left:

`kubectl get deployments,replicasets`{{exec}}

The pods stop, but the Deployment and its ReplicaSet stay, with a count of 0.

Press **Check** when the Deployment asks for 0 copies.

<br>

<details><summary>Tip</summary>

`--replicas=0` is a valid count.

</details>

<details><summary>Solution</summary>

```plain
kubectl scale deployment den-den --replicas=0
kubectl get deployments,replicasets
```{{exec}}

</details>
