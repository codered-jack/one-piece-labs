Add a PodDisruptionBudget named `den-den`, so evictions always leave at least 3 Den Den Mushi ready. It picks its pods by the label `app: den-den`, like the Service. Save it as `~/fleet/den-den-pdb.yaml`, and apply it. Then see how many evictions it allows right now:

`kubectl get pdb den-den`{{exec}}

4 ready, and 3 must stay: `ALLOWED DISRUPTIONS` is 1. Now drain `node01` again, as in step 2. If two or more copies run there, you'll see `Cannot evict pod as it would violate the pod's disruption budget`. The drain retries every 5 seconds, and lets one copy go at a time.

Want to watch callers? Run this in a second terminal (the **+** tab) while you drain. No call should fail:

`kubectl exec lookout -- sh -c 'for i in $(seq 1 300); do wget -qO- -T 2 http://den-den 2>/dev/null || echo FAILED; sleep 0.2; done' | sort | uniq -c`{{exec}}

Press **Check** when the budget is in place, and `node01` is drained.

<br>

<details><summary>Tip</summary>

A PodDisruptionBudget uses `apiVersion: policy/v1`. Its `spec:` holds `minAvailable: 3`, and a `selector:` with `matchLabels:`, as in a Deployment. Then run `kubectl drain node01 --ignore-daemonsets`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/den-den-pdb.yaml <<'EOF'
apiVersion: policy/v1
kind: PodDisruptionBudget
metadata:
  name: den-den
spec:
  minAvailable: 3
  selector:
    matchLabels:
      app: den-den
EOF
kubectl apply -f ~/fleet/den-den-pdb.yaml
kubectl get pdb den-den
kubectl drain node01 --ignore-daemonsets
kubectl rollout status deployment/den-den
```{{exec}}

</details>
