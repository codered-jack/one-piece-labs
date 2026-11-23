Every pod gets its own address on the cluster's network. Show it, and the node the pod runs on:

`kubectl get pods -o wide`{{exec}}

Save the pod's address, from the `IP` column, to `~/ip.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`echo <address> > ~/ip.txt` writes the address to the file.

</details>

<details><summary>Solution</summary>

`-o jsonpath` prints one field instead of the whole table. The pod's address is in its status:

```plain
kubectl get pod den-den -o jsonpath='{.status.podIP}' > ~/ip.txt
cat ~/ip.txt
```{{exec}}

</details>
