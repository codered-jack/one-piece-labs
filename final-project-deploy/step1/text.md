Create the app's namespace, `bounty-board`. Then create a Secret named `db-password` in it, with the key `password` set to the practice password `not-a-real-secret`.

Make it with a command, not a file: a Secret's file would carry the password into Git. Then check it:

`kubectl get secret db-password -n bounty-board`{{exec}}

Press **Check** when it's there.

<br>

<details><summary>Tip</summary>

`kubectl create namespace <name>` makes a namespace. `kubectl create secret generic <name> -n <namespace> --from-literal=<key>=<value>` makes a Secret in it.

</details>

<details><summary>Solution</summary>

```plain
kubectl create namespace bounty-board
kubectl create secret generic db-password -n bounty-board --from-literal=password=not-a-real-secret
kubectl get secret db-password -n bounty-board
```{{exec}}

</details>
