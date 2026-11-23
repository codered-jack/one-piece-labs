The pod's events say why the node restarted it. Find the line that names the liveness probe, and save it to `~/reason.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`kubectl describe pod <pod name>` ends with the pod's events. `grep` keeps the lines that contain some words, and `>` saves them to a file. `kubectl get events` lists the events of every pod in the namespace.

</details>

<details><summary>Solution</summary>

```plain
kubectl get events | grep "failed liveness probe" > ~/reason.txt
cat ~/reason.txt
```{{exec}}

</details>
