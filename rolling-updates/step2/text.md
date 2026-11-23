Change the image in `~/fleet/den-den-deployment.yaml` from `python:3.12-alpine` to `python:3.13-alpine`. See what it would change:

`kubectl diff -f ~/fleet/den-den-deployment.yaml`{{exec}}

Then apply it, and watch the update:

`kubectl rollout status deployment/den-den`{{exec}}

It takes a little while, because the node downloads the new image first. Then list the ReplicaSets:

`kubectl get replicasets`{{exec}}

The new one has the three copies, and the old one has none.

Press **Check** when the update has finished.

<br>

<details><summary>Tip</summary>

`nano ~/fleet/den-den-deployment.yaml` opens the file. Change `3.12` to `3.13`, press `Ctrl+O` and `Enter` to save, and `Ctrl+X` to quit. Then `kubectl apply -f ~/fleet/den-den-deployment.yaml`.

</details>

<details><summary>Solution</summary>

`sed -i` changes the line in place, without an editor:

```plain
sed -i 's/python:3.12-alpine/python:3.13-alpine/' ~/fleet/den-den-deployment.yaml
kubectl apply -f ~/fleet/den-den-deployment.yaml
kubectl rollout status deployment/den-den
kubectl get replicasets
```{{exec}}

</details>
