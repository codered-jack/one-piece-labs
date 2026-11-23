Make a table, and post Robin's bounty. `psql` is Postgres's command-line tool:

`kubectl exec db -- psql -U postgres -c "CREATE TABLE bounties (name text, bounty bigint)"`{{exec}}

`kubectl exec db -- psql -U postgres -c "INSERT INTO bounties VALUES ('Nico Robin', 930000000)"`{{exec}}

If `psql` can't connect yet, Postgres is still starting: wait a few seconds, and try again.

Now lose the pod: delete it, and start it again from `~/fleet/db.yaml`. Wait until it's ready, then ask for the bounties:

`kubectl exec db -- psql -U postgres -c "SELECT * FROM bounties"`{{exec}}

Press **Check** when Robin has survived the new pod.

<br>

<details><summary>Tip</summary>

`kubectl delete pod db`, then `kubectl apply -f ~/fleet/db.yaml`. The claim, and its disk, stay.

</details>

<details><summary>Solution</summary>

```plain
sleep 5
kubectl exec db -- psql -U postgres -c "CREATE TABLE bounties (name text, bounty bigint)"
kubectl exec db -- psql -U postgres -c "INSERT INTO bounties VALUES ('Nico Robin', 930000000)"
kubectl delete pod db
kubectl apply -f ~/fleet/db.yaml
kubectl wait --for=condition=Ready pod/db --timeout=90s
sleep 5
kubectl exec db -- psql -U postgres -c "SELECT * FROM bounties"
kubectl logs db | head -3
```{{exec}}

</details>
