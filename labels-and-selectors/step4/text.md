The lookout is moving to the Grand Line. Change its `sea` label from `east-blue` to `grand-line`, without restarting it.

Then check:

`kubectl get pods -L sea`{{exec}}

Press **Check** when the lookout shows `grand-line`.

<br>

<details><summary>Tip</summary>

`kubectl label pod <name> <key>=<value>` sets a label. To change one that already has a value, add `--overwrite`.

</details>

<details><summary>Solution</summary>

```plain
kubectl label pod lookout sea=grand-line --overwrite
```{{exec}}

</details>
