Deleting a namespace deletes everything in it. Delete the stowaway's namespace, and the stowaway goes with it.

Then check that the namespace is gone:

`kubectl get namespaces`{{exec}}

It may show `Terminating` for a few seconds first.

Press **Check** when it's done.

<br>

<details><summary>Tip</summary>

`kubectl delete namespace` takes the namespace's name, the one you saved in `~/hideout.txt`.

</details>

<details><summary>Solution</summary>

```plain
kubectl delete namespace cargo-hold
```{{exec}}

</details>
