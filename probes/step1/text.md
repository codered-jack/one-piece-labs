Right now, a Den Den Mushi gets calls as soon as its container starts, 10 seconds before it can answer. Call the Service:

`kubectl exec lookout -- wget -qO- -T 2 http://den-den`{{exec}}

In `~/fleet/den-den-deployment.yaml`, add a readiness probe to the container. It asks for `/ready` on port 8000, every 2 seconds. Apply it, and wait for the rollout:

`kubectl rollout status deployment/den-den`{{exec}}

New pods show `0/1` for about 10 seconds, then `1/1`:

`kubectl get pods -l app=den-den`{{exec}}

Press **Check** when the rollout is done.

<br>

<details><summary>Tip</summary>

Under the container, above `ports:`, add `readinessProbe:` with `httpGet:` (holding `path: /ready` and `port: 8000`), and `periodSeconds: 2`. Open the file with `nano ~/fleet/den-den-deployment.yaml`. Ctrl+O, then Enter, saves; Ctrl+X quits.

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
          command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && touch ready alive && sleep 10 && python3 -m http.server 8000"]
          readinessProbe:
            httpGet:
              path: /ready
              port: 8000
            periodSeconds: 2
          ports:
            - containerPort: 8000
EOF
kubectl apply -f ~/fleet/den-den-deployment.yaml
kubectl rollout status deployment/den-den
kubectl get pods -l app=den-den
```{{exec}}

</details>
