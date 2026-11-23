`db-0` has a disk of its own, so it starts empty. Post Robin there:

`kubectl exec db-0 -- psql -U postgres -c "CREATE TABLE bounties (name text, bounty bigint)"`{{exec}}

`kubectl exec db-0 -- psql -U postgres -c "INSERT INTO bounties VALUES ('Nico Robin', 930000000)"`{{exec}}

Now delete the pod `db-0`, and watch what comes back:

`kubectl get pods -l app=db`{{exec}}

Once it's ready, ask the new pod for the bounties.

Press **Check** when Robin has survived the new `db-0`.

<br>

<details><summary>Tip</summary>

`kubectl delete pod db-0`. The StatefulSet makes a new pod with the same name, on the same claim.

</details>

<details><summary>Solution</summary>

```plain
sleep 5
kubectl exec db-0 -- psql -U postgres -c "CREATE TABLE bounties (name text, bounty bigint)"
kubectl exec db-0 -- psql -U postgres -c "INSERT INTO bounties VALUES ('Nico Robin', 930000000)"
kubectl delete pod db-0
kubectl wait --for=condition=Ready pod/db-0 --timeout=90s
sleep 5
kubectl exec db-0 -- psql -U postgres -c "SELECT * FROM bounties"
```{{exec}}

</details>
