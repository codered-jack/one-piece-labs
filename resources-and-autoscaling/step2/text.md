This node has 1 CPU. Write `~/fleet/giant.yaml`, a pod named `giant` that runs `sleep 3600` in `python:3.13-alpine`, and asks for 20 CPUs. Apply it, and look at it:

`kubectl get pod giant`{{exec}}

It stays `Pending`. Find out why:

`kubectl describe pod giant`{{exec}}

Press **Check** when the events say why.

<br>

<details><summary>Tip</summary>

Under the container, add `resources:`, then `requests:`, then `cpu: "20"`. The quotes keep it a piece of text, as Kubernetes expects. Only a request: a limit of 20 CPUs isn't needed.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/giant.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: giant
spec:
  containers:
    - name: giant
      image: python:3.13-alpine
      command: ["sleep", "3600"]
      resources:
        requests:
          cpu: "20"
EOF
kubectl apply -f ~/fleet/giant.yaml
sleep 3
kubectl describe pod giant | grep -A5 Events
```{{exec}}

</details>
