Look at the Den Den Mushi's page. Nothing gives it `$SHIP`, so the ship's name is missing:

`kubectl exec deploy/den-den -- cat index.html`{{exec}}

Write `~/fleet/ship-settings.yaml`: a ConfigMap named `ship-settings`, with one setting, `SHIP`, set to `Going Merry`. Apply it, and check:

`kubectl describe configmap ship-settings`{{exec}}

Press **Check** when it's there.

<br>

<details><summary>Tip</summary>

A ConfigMap starts with `apiVersion: v1` and `kind: ConfigMap`. Its settings go under `data:`, one `NAME: value` per line. Or let `kubectl create configmap ... --dry-run=client -o yaml` write the file.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/ship-settings.yaml <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: ship-settings
data:
  SHIP: Going Merry
EOF
kubectl apply -f ~/fleet/ship-settings.yaml
kubectl describe configmap ship-settings
```{{exec}}

</details>
