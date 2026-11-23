A selector works with `delete` too. Delete every pod with `app=den-den` in **one** command, and leave the lookout and the cook alone.

First, list what the selector matches, so you know what you're deleting:

`kubectl get pods -l app=den-den`{{exec}}

Deleting waits up to 30 seconds per pod for it to stop. `--now` skips most of the wait.

Press **Check** when only the lookout and the cook are left.

<br>

<details><summary>Tip</summary>

`kubectl delete pods -l <selector>` deletes every pod the selector matches.

</details>

<details><summary>Solution</summary>

```plain
kubectl delete pods -l app=den-den --now
kubectl get pods --show-labels
```{{exec}}

</details>
