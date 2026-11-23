Make a folder for your manifests, and go into it:

`mkdir -p ~/fleet && cd ~/fleet`{{exec}}

In it, write `den-den-deployment.yaml`: a Deployment named `den-den` that keeps **3** copies running. Its selector picks the pods labelled `app: den-den`. Its template is the Den Den Mushi pod from the ***Pods*** lab, with the label `app: den-den`: one container named `den-den`, running `python:3.12-alpine` on port 8000, with this command:

```plain
sh -c 'echo "Purupurupuru! $(hostname) here." > index.html && python3 -m http.server 8000'
```

Apply it, then wait for all three copies:

`kubectl rollout status deployment/den-den`{{exec}}

Press **Check** when it says `successfully rolled out`.

<br>

<details><summary>Tip</summary>

A Deployment starts with `apiVersion: apps/v1` and `kind: Deployment`. Under `spec:` go `replicas:`, `selector:` with `matchLabels:`, and `template:`. The template has a pod's `metadata:` and `spec:`. Its labels must match the selector.

</details>

<details><summary>Solution</summary>

```plain
mkdir -p ~/fleet && cd ~/fleet
cat > den-den-deployment.yaml <<'EOF'
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
          image: python:3.12-alpine
          command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && python3 -m http.server 8000"]
          ports:
            - containerPort: 8000
EOF
kubectl apply -f den-den-deployment.yaml
kubectl rollout status deployment/den-den
```{{exec}}

</details>
