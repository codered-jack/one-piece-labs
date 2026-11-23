`~/fleet/hungry.yaml` is a pod that takes 100 MiB of memory, then sleeps. First run it as it is, with no limit:

`kubectl apply -f ~/fleet/hungry.yaml`{{exec}}

It runs fine. Within a minute or two, metrics-server can measure it:

`kubectl top pod hungry`{{exec}}

Now give its container a memory limit of `64Mi`. A running pod's limits can't be changed, so delete it, and apply the file again. Wait half a minute, and look at it:

`kubectl get pod hungry`{{exec}}

Press **Check** when it shows `OOMKilled` or `CrashLoopBackOff`.

<br>

<details><summary>Tip</summary>

Under the container, add `resources:`, then `limits:`, then `memory: 64Mi`. Delete the pod with `kubectl delete pod hungry --now`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/hungry.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: hungry
spec:
  containers:
    - name: hungry
      image: python:3.13-alpine
      command: ["python3", "-c", "b = bytearray(100 * 1024 * 1024); import time; time.sleep(3600)"]
      resources:
        limits:
          memory: 64Mi
EOF
kubectl delete pod hungry --now --ignore-not-found
kubectl apply -f ~/fleet/hungry.yaml
sleep 15
kubectl get pod hungry
```{{exec}}

</details>
