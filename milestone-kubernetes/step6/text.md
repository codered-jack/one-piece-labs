Delete the database's pod. The Deployment makes a new one.

The cache keeps a copy of the list for 30 seconds, so the board may still show Robin for a while. Wait 30 seconds, then count the posters:

`curl -s localhost:9000/api/bounties | grep -o '"id"' | wc -l`{{exec}}

Each bounty has one `"id"`, so this counts them. Save the count to `~/count.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`kubectl delete pod -n bounty-board -l app=db` deletes the pod with that label. Put `> ~/count.txt` after the count's command to save it.

</details>

<details><summary>Solution</summary>

The new database started empty, so Postgres ran `init.sql` again: the first five bounties, and no Robin.

```plain
kubectl delete pod -n bounty-board -l app=db
kubectl rollout status -n bounty-board deployment/db
sleep 30
curl -s localhost:9000/api/bounties | grep -o '"id"' | wc -l > ~/count.txt
cat ~/count.txt
```{{exec}}

</details>
