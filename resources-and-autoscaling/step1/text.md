In `~/fleet/den-den-deployment.yaml`, give the Den Den Mushi's container:

- a request of `50m` CPU and `32Mi` memory
- a limit of `200m` CPU and `64Mi` memory

Apply it, and wait for the rollout:

`kubectl rollout status deployment/den-den`{{exec}}

The node's tally now counts them:

`kubectl describe node | grep -A8 "Allocated resources"`{{exec}}

Press **Check** when the rollout is done.

<br>

<details><summary>Tip</summary>

Under the container, above `ports:`, add `resources:`, with `requests:` and `limits:` under it. Each holds a `cpu:` and a `memory:`. Open the file with `nano ~/fleet/den-den-deployment.yaml`. Ctrl+O, then Enter, saves; Ctrl+X quits.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/den-den-deployment.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: den-den
spec:
  replicas: 3
  selector:
    matchLabels:
      app: den-den
  template:
    metadata:
      labels:
        app: den-den
    spec:
      containers:
        - name: den-den
          image: python:3.13-alpine
          command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && python3 -m http.server 8000"]
          resources:
            requests:
              cpu: 50m
              memory: 32Mi
            limits:
              cpu: 200m
              memory: 64Mi
          ports:
            - containerPort: 8000
EOF
kubectl apply -f ~/fleet/den-den-deployment.yaml
kubectl rollout status deployment/den-den
```{{exec}}

</details>
