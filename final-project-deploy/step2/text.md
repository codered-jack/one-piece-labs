First, wait until the machine has finished getting ready. This prints `ready` when it has:

`until [ -f ~/.setup-done ]; do sleep 2; done; echo ready`{{exec}}

Go to the app's folder. `final/` holds a copy of the milestone's manifests:

`cd ~/one-piece-labs/bounty-board && ls final`{{exec}}

Both the database and the API need the user name and the database's name. Write `final/settings.yaml`: a ConfigMap named `db-settings`, with `POSTGRES_USER` set to `bounty` and `POSTGRES_DB` set to `bounties`. Apply it into the namespace:

`kubectl apply -n bounty-board -f final/settings.yaml`{{exec}}

Press **Check** when it's applied.

<br>

<details><summary>Tip</summary>

A ConfigMap has `apiVersion: v1`, `kind: ConfigMap`, a `metadata:` with its `name:`, and `data:`, holding one `KEY: value` line per setting.

</details>

<details><summary>Solution</summary>

```plain
until [ -f ~/.setup-done ]; do sleep 2; done
cd ~/one-piece-labs/bounty-board
cat > final/settings.yaml <<'EOF'
apiVersion: v1
kind: ConfigMap
metadata:
  name: db-settings
data:
  POSTGRES_USER: bounty
  POSTGRES_DB: bounties
EOF
kubectl apply -n bounty-board -f final/settings.yaml
```{{exec}}

</details>
