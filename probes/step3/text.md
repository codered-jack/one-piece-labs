Now catch a stuck Den Den Mushi. In `~/fleet/den-den-deployment.yaml`, add two more probes to the container:

- a liveness probe that asks for `/alive` on port 8000, every 2 seconds
- a startup probe, also on `/alive`, that allows 15 failures, 2 seconds apart. That gives the app 30 seconds to start.

Without the startup probe, the liveness probe would restart each new copy before its 10-second start is over. Apply it, and wait for the rollout:

`kubectl rollout status deployment/den-den`{{exec}}

The new pods replace the one you took off the line. Each should have no restarts:

`kubectl get pods -l app=den-den`{{exec}}

Press **Check** when the rollout is done.

<br>

<details><summary>Tip</summary>

Add `livenessProbe:` and `startupProbe:` next to `readinessProbe:`, written the same way. The startup probe also needs `failureThreshold: 15`.

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
          livenessProbe:
            httpGet:
              path: /alive
              port: 8000
            periodSeconds: 2
          startupProbe:
            httpGet:
              path: /alive
              port: 8000
            periodSeconds: 2
            failureThreshold: 15
          ports:
            - containerPort: 8000
EOF
kubectl apply -f ~/fleet/den-den-deployment.yaml
kubectl rollout status deployment/den-den
kubectl get pods -l app=den-den
```{{exec}}

</details>
