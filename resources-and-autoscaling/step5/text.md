Make the Den Den Mushi busy. Start a pod named `load` that calls it as fast as it can, forever:

`kubectl run load --image=alpine -- sh -c 'while true; do wget -qO- http://den-den > /dev/null; done'`{{exec}}

Watch the autoscaler. Press Ctrl+C to stop watching:

`kubectl get hpa den-den -w`{{exec}}

Within a minute or two, `TARGETS` goes well over 50%, and `REPLICAS` grows. Press **Check** when it's over 1.

<br>

<details><summary>Tip</summary>

The command above is the whole task. If `REPLICAS` stays at 1, check that `load` is `Running`, with `kubectl get pod load`.

</details>

<details><summary>Solution</summary>

```plain
kubectl run load --image=alpine -- sh -c 'while true; do wget -qO- http://den-den > /dev/null; done'
until [ "$(kubectl get hpa den-den -o jsonpath='{.status.currentReplicas}')" -gt 1 ]; do sleep 5; done
kubectl get hpa den-den
```{{exec}}

</details>
