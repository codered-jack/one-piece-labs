In the milestone, Robin disappeared with the database's pod. Delete `db-0` now, and watch the StatefulSet make a new one:

`kubectl get pods -n bounty-board -l app=db`{{exec}}

The cache keeps a copy of the list for 30 seconds. Wait 30 seconds, then count the posters:

`curl -s localhost:9000/api/bounties | grep -o '"id"' | wc -l`{{exec}}

Save the count to `~/count.txt`. The new pod's log says why the data survived:

`kubectl logs -n bounty-board db-0 | head -2`{{exec}}

Press **Check** when the count is saved.

<br>

<details><summary>Tip</summary>

`kubectl delete pod db-0 -n bounty-board` deletes the pod. Put `> ~/count.txt` after the count's command to save it.

</details>

<details><summary>Solution</summary>

The new `db-0` found its old disk, so Postgres skipped `init.sql`, and Robin is still there: 6 posters.

```plain
kubectl delete pod db-0 -n bounty-board
kubectl wait pod db-0 -n bounty-board --for=condition=Ready --timeout=120s
sleep 30
curl -s localhost:9000/api/bounties | grep -o '"id"' | wc -l > ~/count.txt
cat ~/count.txt
```{{exec}}

</details>
