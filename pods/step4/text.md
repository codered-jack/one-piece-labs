A pod's containers share one network address, so they reach each other on `localhost`.

Write `~/fleet/watchtower.yaml`: a pod named `watchtower`, with **two** containers:

- `den-den`: the Den Den Mushi, as in the first step
- `lookout`: runs `alpine` with this command, which calls the Den Den Mushi every 5 seconds

```plain
sh -c 'while true; do wget -qO- http://127.0.0.1:8000; sleep 5; done'
```

Apply it. Then, once `kubectl get pods` shows `2/2`, read the lookout's logs:

`kubectl logs watchtower -c lookout`{{exec}}

Press **Check** when the lookout has heard the Den Den Mushi.

<br>

<details><summary>Tip</summary>

The second container is a second item in the `containers:` list, starting with its own `- name:`. `-c lookout` picks which container's logs to show.

</details>

<details><summary>Solution</summary>

```plain
mkdir -p ~/fleet && cd ~/fleet
cat > watchtower.yaml <<'EOF'
apiVersion: v1
kind: Pod
metadata:
  name: watchtower
spec:
  containers:
    - name: den-den
      image: python:3.12-alpine
      command: ["sh", "-c", "echo \"Purupurupuru! $(hostname) here.\" > index.html && python3 -m http.server 8000"]
    - name: lookout
      image: alpine
      command: ["sh", "-c", "while true; do wget -qO- http://127.0.0.1:8000; sleep 5; done"]
EOF
kubectl apply -f watchtower.yaml
```{{exec}}

</details>
