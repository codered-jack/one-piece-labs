Make a namespace named `bounty-board`. Then apply the whole `k8s` folder into it.

Watch the pods start:

`kubectl get pods -n bounty-board`{{exec}}

Six pods: two `web`, two `api`, one `cache` and one `db`. Then the four Services:

`kubectl get services -n bounty-board`{{exec}}

Press **Check** when every pod is `Running`.

<br>

<details><summary>Tip</summary>

`kubectl create namespace <name>` makes the namespace. `kubectl apply -n <namespace> -f <folder>/` applies every file in the folder, into the namespace.

</details>

<details><summary>Solution</summary>

```plain
cd ~/one-piece-labs/bounty-board
kubectl create namespace bounty-board
kubectl apply -n bounty-board -f k8s/
for d in db cache api web; do kubectl rollout status -n bounty-board deployment/$d; done
```{{exec}}

</details>
