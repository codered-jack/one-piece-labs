List the API's two pods:

`kubectl get pods -n bounty-board -l app=api`{{exec}}

Delete one of them. Then reload the board: it still works, because the other copy takes the calls. List the pods again, and a new one is there.

Then scale the API to **3** copies.

Press **Check** when three API pods are ready.

<br>

<details><summary>Tip</summary>

`kubectl delete pod -n bounty-board <name>` deletes a pod. `kubectl scale deployment <name> -n bounty-board --replicas=<count>` scales a Deployment.

</details>

<details><summary>Solution</summary>

```plain
POD=$(kubectl get pods -n bounty-board -l app=api -o jsonpath='{.items[0].metadata.name}')
kubectl delete pod -n bounty-board "$POD"
kubectl scale deployment api -n bounty-board --replicas=3
kubectl rollout status -n bounty-board deployment/api
kubectl get pods -n bounty-board -l app=api
```{{exec}}

</details>
