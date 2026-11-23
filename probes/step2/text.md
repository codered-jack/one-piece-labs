Take one Den Den Mushi off the line, without restarting it. Its readiness probe asks for the file `ready`: delete that file in one pod. List the pods to pick one:

`kubectl get pods -l app=den-den`{{exec}}

Within a few seconds, that pod shows `0/1`, with no restarts. Call the Service 12 times. No answer comes from that pod:

`kubectl exec lookout -- sh -c 'for i in $(seq 1 12); do wget -qO- -T 2 http://den-den 2>/dev/null || echo FAILED; done' | sort | uniq -c`{{exec}}

Press **Check** while it's off the line.

<br>

<details><summary>Tip</summary>

`kubectl exec <pod name> -- rm ready` deletes the file inside that pod. `kubectl exec <pod name> -- touch ready` would put it back, but leave it gone for the check.

</details>

<details><summary>Solution</summary>

```plain
P=$(kubectl get pods -l app=den-den -o go-template='{{range .items}}{{if not .metadata.deletionTimestamp}}{{.metadata.name}} {{end}}{{end}}' | awk '{print $1}')
kubectl exec "$P" -- rm ready
sleep 8
kubectl get pods -l app=den-den
```{{exec}}

</details>
