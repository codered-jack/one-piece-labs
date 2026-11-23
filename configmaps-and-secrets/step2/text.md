Hand the settings to the Den Den Mushi. In `~/fleet/den-den-deployment.yaml`, give the container every setting in `ship-settings`, as environment variables. Apply it, and wait for the new pods:

`kubectl rollout status deployment/den-den`{{exec}}

Then look at the page again:

`kubectl exec deploy/den-den -- cat index.html`{{exec}}

Press **Check** when it names the Going Merry.

<br>

<details><summary>Tip</summary>

Under the container, next to `image:`, add `envFrom:`: a list with one item, `configMapRef:`, which takes the ConfigMap's `name:`. Open the file with `nano ~/fleet/den-den-deployment.yaml`. Ctrl+O, then Enter, saves; Ctrl+X quits.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/den-den-deployment.yaml <<'EOF'
apiVersion: apps/v1
kind: Deployment
metadata:
  name: den-den
spec:
  replicas: 2
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
          command: ["sh", "-c", "echo \"Purupurupuru! The $SHIP calling. $(hostname) here.\" > index.html && python3 -m http.server 8000"]
          envFrom:
            - configMapRef:
                name: ship-settings
          ports:
            - containerPort: 8000
EOF
kubectl apply -f ~/fleet/den-den-deployment.yaml
kubectl rollout status deployment/den-den
kubectl exec deploy/den-den -- cat index.html
```{{exec}}

</details>
