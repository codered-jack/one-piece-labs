Make a folder for your manifests, and go into it:

`mkdir -p ~/fleet && cd ~/fleet`{{exec}}

In it, write `den-den.yaml`: a pod named `den-den`, with one container, also named `den-den`. It runs `python:3.12-alpine` with this command, and listens on port 8000:

```plain
sh -c 'echo "Purupurupuru! $(hostname) here." > index.html && python3 -m http.server 8000'
```

Apply it, then watch it start:

`kubectl get pods`{{exec}}

Press **Check** when it says `Running`. If the check fails at first, wait a few seconds and press it again: `Running` means the container has started, and the server inside needs a moment more.

<br>

<details><summary>Tip</summary>

A manifest starts with `apiVersion: v1` and `kind: Pod`. The name goes under `metadata:`, and the containers go in a list under `spec:`. `command:` takes the command as a list, one word per item: `["sh", "-c", "…"]`. Inside that last item, write each `"` as `\"`.

</details>

<details><summary>Solution</summary>

This writes the file without an editor, then applies it:

```plain
mkdir -p ~/fleet && cd ~/fleet
cat > den-den.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: den-den
spec:
  containers:
    - name: den-den
      image: python:3.12-alpine
      command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && python3 -m http.server 8000"]
      ports:
        - containerPort: 8000
EOF
kubectl apply -f den-den.yaml
```{{exec}}

</details>
