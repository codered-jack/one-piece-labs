Postgres needs a password. Keep it in a Secret: create one named `db-password`, with the key `password` set to the practice password `not-a-real-secret`.

Then look at it:

`kubectl describe secret db-password`{{exec}}

`describe` shows only the size. Turn the stored value back into text:

`kubectl get secret db-password -o jsonpath='{.data.password}' | base64 -d; echo`{{exec}}

It's base64, not a lock: anyone who can read the Secret can read the password.

Press **Check** when the Secret is there.

<br>

<details><summary>Tip</summary>

`kubectl create secret generic <name> --from-literal=<key>=<value>` creates a Secret from the command line.

</details>

<details><summary>Solution</summary>

```plain
kubectl create secret generic db-password --from-literal=password=not-a-real-secret
kubectl describe secret db-password
```{{exec}}

</details>
