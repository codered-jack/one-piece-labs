Call the Den Den Mushi from inside its own pod, and save its answer to `~/reply.txt`.

Then read what the server printed about the call:

`kubectl logs den-den`{{exec}}

Press **Check** when `~/reply.txt` holds the answer.

<br>

<details><summary>Tip</summary>

`kubectl exec den-den -- <command>` runs a command in the pod. Alpine has `wget`: `wget -qO- <address>` prints a page. `>` saves what a command prints to a file.

</details>

<details><summary>Solution</summary>

```plain
kubectl exec den-den -- wget -qO- http://127.0.0.1:8000 > ~/reply.txt
cat ~/reply.txt
```{{exec}}

</details>
