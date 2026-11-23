A pod named `stowaway` is hiding somewhere on this cluster. It isn't in `default`:

`kubectl get pods`{{exec}}

Find the namespace it's in, and save that namespace's name to `~/hideout.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`-A` lists pods in every namespace, with a `NAMESPACE` column.

</details>

<details><summary>Solution</summary>

```plain
kubectl get pods -A
```{{exec}}

The `NAMESPACE` column on the `stowaway` row says `cargo-hold`:

```plain
echo cargo-hold > ~/hideout.txt
```{{exec}}

</details>
