In a manifest, labels go under `metadata:`, next to the name. Make a folder for your manifests:

`mkdir -p ~/fleet && cd ~/fleet`{{exec}}

In it, write `den-den-grand.yaml`: a pod named `den-den-grand`, with the labels `app: den-den` and `sea: grand-line`. Its one container, also named `den-den-grand`, runs `python:3.12-alpine` with the command `python3 -m http.server 8000`. Apply it.

Then list the pods with their labels as columns:

`kubectl get pods -L app,sea`{{exec}}

Press **Check** when `den-den-grand` shows both labels.

<br>

<details><summary>Tip</summary>

Under `metadata:` go `name:` and `labels:`, and under `labels:` go the two `key: value` lines. The command is a list: `["python3", "-m", "http.server", "8000"]`.

</details>

<details><summary>Solution</summary>

```plain
mkdir -p ~/fleet && cd ~/fleet
cat > den-den-grand.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: den-den-grand
  labels:
    app: den-den
    sea: grand-line
spec:
  containers:
    - name: den-den-grand
      image: python:3.12-alpine
      command: ["python3", "-m", "http.server", "8000"]
EOF
kubectl apply -f den-den-grand.yaml
```{{exec}}

</details>
