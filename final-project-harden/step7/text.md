Make the board busy. Start a pod named `load` that asks for the list as fast as it can, forever:

`kubectl run load -n bounty-board --image=alpine -- sh -c 'while true; do wget -qO- http://front-door-nginx/api/bounties > /dev/null; done'`{{exec}}

Watch the HPA. Press Ctrl+C to stop watching:

`kubectl get hpa api -n bounty-board -w`{{exec}}

Within a minute or two, `TARGETS` goes well over 50%, and `REPLICAS` grows. Press **Check** when it's over 2.

When you're done, stop the load. The HPA waits 5 minutes of low use before it removes copies:

`kubectl delete pod load -n bounty-board`{{exec}}

<br>

<details><summary>Tip</summary>

The first command is the whole task. If `REPLICAS` stays at 2, check that `load` is `Running`, with `kubectl get pod load -n bounty-board`.

</details>

<details><summary>Solution</summary>

```plain
kubectl run load -n bounty-board --image=alpine -- sh -c 'while true; do wget -qO- http://front-door-nginx/api/bounties > /dev/null; done'
until [ "$(kubectl get hpa api -n bounty-board -o jsonpath='{.status.currentReplicas}')" -gt 2 ]; do sleep 5; done
kubectl get hpa api -n bounty-board
```{{exec}}

</details>
