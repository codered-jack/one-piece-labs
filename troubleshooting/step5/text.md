Everything works now. Time to clear the decks.

`kubectl delete -f` takes a file, like `kubectl apply -f`, and deletes what the file made. Given a folder, it does every file in it. Delete everything the files in `~/fleet` made, in one command.

Then check:

`kubectl get deployments,services`{{exec}}

Only the `kubernetes` Service should be left. Press **Check** when it is.

<br>

<details><summary>Tip</summary>

`kubectl delete -f <folder>/` works on every file in the folder.

</details>

<details><summary>Solution</summary>

```plain
kubectl delete -f ~/fleet/
kubectl get deployments,services
```{{exec}}

</details>
