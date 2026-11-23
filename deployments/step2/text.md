The Deployment didn't make the pods itself. It made a ReplicaSet, and the ReplicaSet made the pods. List both:

`kubectl get replicasets`{{exec}}

`kubectl get pods`{{exec}}

Every pod's name starts with the ReplicaSet's name. Save the ReplicaSet's name to `~/replicaset.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

It's `den-den-` and a code, like `den-den-78bdf5fbb4`. `-o name` prints it as `replicaset.apps/<name>`. The check accepts it with or without that start.

</details>

<details><summary>Solution</summary>

```plain
kubectl get replicasets -o name > ~/replicaset.txt
cat ~/replicaset.txt
```{{exec}}

</details>
