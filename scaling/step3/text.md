The file still says `replicas: 3`. Applying it would undo your `kubectl scale`, so put the count you want in the file instead.

Change `~/fleet/den-den-deployment.yaml` to **4** copies. Before you apply it, see what it would change:

`kubectl diff -f ~/fleet/den-den-deployment.yaml`{{exec}}

Lines with `-` are what the cluster has now, and lines with `+` are what your file says. Then apply it.

Press **Check** when the file says 4, and the Deployment shows `4/4`.

<br>

<details><summary>Tip</summary>

`nano ~/fleet/den-den-deployment.yaml` opens the file. Change the number, press `Ctrl+O` and `Enter` to save, and `Ctrl+X` to quit. Then `kubectl apply -f ~/fleet/den-den-deployment.yaml`.

</details>

<details><summary>Solution</summary>

`sed -i` changes the line in place, without an editor:

```plain
sed -i 's/replicas: 3/replicas: 4/' ~/fleet/den-den-deployment.yaml
kubectl diff -f ~/fleet/den-den-deployment.yaml
kubectl apply -f ~/fleet/den-den-deployment.yaml
kubectl rollout status deployment/den-den
```{{exec}}

</details>
