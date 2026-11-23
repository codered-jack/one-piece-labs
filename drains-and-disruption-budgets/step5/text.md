A budget can be too strict. First, put copies back on `node01`, as in step 3: open it, and restart the Deployment.

`kubectl rollout status deployment/den-den`{{exec}}

Now change the budget to `minAvailable: 4`, and apply it. 4 copies, and all 4 must stay:

`kubectl get pdb den-den`{{exec}}

`ALLOWED DISRUPTIONS` is 0. Try to drain `node01` once more. Add `--timeout=30s`, so the drain gives up after 30 seconds instead of retrying forever. Save everything it prints, errors included, to `~/blocked.txt`.

Open the node again afterwards: a drain that gives up leaves it cordoned.

Press **Check** when `~/blocked.txt` shows the budget refusing the drain.

<br>

<details><summary>Tip</summary>

Errors go to a separate stream from normal output. `> ~/blocked.txt 2>&1` saves both to the file. Change the number with `nano ~/fleet/den-den-pdb.yaml`, or with `sed -i 's/minAvailable: 3/minAvailable: 4/' ~/fleet/den-den-pdb.yaml`.

</details>

<details><summary>Solution</summary>

```plain
kubectl uncordon node01
kubectl rollout restart deployment/den-den
kubectl rollout status deployment/den-den
sed -i 's/minAvailable: 3/minAvailable: 4/' ~/fleet/den-den-pdb.yaml
kubectl apply -f ~/fleet/den-den-pdb.yaml
kubectl get pdb den-den
kubectl drain node01 --ignore-daemonsets --timeout=30s > ~/blocked.txt 2>&1
kubectl uncordon node01
grep -m 1 "disruption budget" ~/blocked.txt
```{{exec}}

</details>
