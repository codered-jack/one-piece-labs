List the cluster's nodes:

`kubectl get nodes`{{exec}}

There's one, and its `STATUS` should be `Ready`. Save its name, from the `NAME` column, to `~/node.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`echo <name> > ~/node.txt` writes a name to the file, as in the ***Your terminal in 20 minutes*** lesson.

</details>

<details><summary>Solution</summary>

`-o jsonpath` prints one field instead of the whole table. Here, it's the first node's name:

```plain
kubectl get nodes -o jsonpath='{.items[0].metadata.name}' > ~/node.txt
cat ~/node.txt
```{{exec}}

</details>
