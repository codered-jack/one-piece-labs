Create a namespace named `grand-line`. Then look inside it:

`kubectl get pods -n grand-line`{{exec}}

It says `No resources found in grand-line namespace.`: it's new, so it's empty.

Press **Check** when the namespace exists.

<br>

<details><summary>Tip</summary>

`kubectl create namespace` takes the new namespace's name.

</details>

<details><summary>Solution</summary>

```plain
kubectl create namespace grand-line
```{{exec}}

</details>
