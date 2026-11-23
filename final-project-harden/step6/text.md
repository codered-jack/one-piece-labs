Ship version `1.1` of the API while visitors keep calling. Build it, and copy it into the cluster:

`docker build -t bounty-board-api:1.1 api`{{exec}}

`docker save bounty-board-api:1.1 | ctr -n k8s.io images import -`{{exec}}

Change the API's `image:` in `final/api.yaml` to `bounty-board-api:1.1`. Then start 300 calls through the front door, and save what they print to `~/update.txt`. The `&` at the end runs them in the background, so you can keep typing:

`(kubectl exec -n bounty-board lookout -- sh -c 'for i in $(seq 1 300); do wget -qO- -T 2 http://front-door-nginx/api/bounties > /dev/null 2>&1 && echo answered || echo FAILED; sleep 0.2; done' | sort | uniq -c > ~/update.txt) &`{{exec}}

While they run, apply the folder and watch the update:

`kubectl apply -n bounty-board -f final/`{{exec}}

`kubectl rollout status -n bounty-board deployment/api`{{exec}}

`wait` waits for the calls to finish, after about a minute. Then look at the result:

`wait; cat ~/update.txt`{{exec}}

Press **Check** when the API runs `1.1`, and no call failed.

<br>

<details><summary>Tip</summary>

The code in `1.1` is the same as in `1.0`. The test is that nobody notices the update. If you see `FAILED`, check that the readiness probe and the `preStop` pause are on the API, then run the calls again with `kubectl rollout restart -n bounty-board deployment/api` as the update.

</details>

<details><summary>Solution</summary>

```plain
cd ~/one-piece-labs/bounty-board
docker build -t bounty-board-api:1.1 api
docker save bounty-board-api:1.1 | ctr -n k8s.io images import -
sed -i 's#bounty-board-api:1.0#bounty-board-api:1.1#' final/api.yaml
(kubectl exec -n bounty-board lookout -- sh -c 'for i in $(seq 1 300); do wget -qO- -T 2 http://front-door-nginx/api/bounties > /dev/null 2>&1 && echo answered || echo FAILED; sleep 0.2; done' | sort | uniq -c > ~/update.txt) &
sleep 5
kubectl apply -n bounty-board -f final/
kubectl rollout status -n bounty-board deployment/api
wait
cat ~/update.txt
```{{exec}}

</details>
