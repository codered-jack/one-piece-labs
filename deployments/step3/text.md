Pick one of the three pods. Save its name to `~/sunk.txt`, then delete it. The delete takes about 30 seconds, while the pod stops.

Then list the pods:

`kubectl get pods`{{exec}}

There are three again. Look at the `AGE` column: the new pod started the moment you asked for the delete.

Press **Check** when your pod is gone and three are running.

<br>

<details><summary>Tip</summary>

`kubectl get pods` lists the names. `echo <name> > ~/sunk.txt` saves one, and `kubectl delete pod <name>` deletes it.

</details>

<details><summary>Solution</summary>

This saves the first pod's name, then deletes that pod:

```plain
POD=$(kubectl get pods -l app=den-den -o jsonpath='{.items[0].metadata.name}')
echo "$POD" > ~/sunk.txt
kubectl delete pod "$POD"
kubectl get pods
```{{exec}}

</details>
