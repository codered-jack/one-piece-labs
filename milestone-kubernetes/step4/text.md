Connect port 9000 on this machine to the `web` Service. The `&` at the end runs it in the background, so you keep your prompt:

`kubectl port-forward -n bounty-board service/web 9000:80 --address 0.0.0.0 > /dev/null 2>&1 &`{{exec}}

`--address 0.0.0.0` lets the link below reach it. Without it, `port-forward` only answers on this machine's own `localhost`.

[Open the Bounty Board]({{TRAFFIC_HOST1_9000}}) in a new browser tab. It shows five wanted posters. Check its health too:

`curl -s localhost:9000/api/health`{{exec}}

Now post a bounty of **930000000** berries for **Nico Robin**, with the form on the page, or with `curl`.

Press **Check** when Robin is on the board.

<br>

<details><summary>Tip</summary>

The API takes a new bounty at `/api/bounties`, as JSON: `{"name": "Nico Robin", "bounty": 930000000}`. `curl -X POST -H 'Content-Type: application/json' -d '<json>' <address>` sends it.

</details>

<details><summary>Solution</summary>

```plain
kubectl port-forward -n bounty-board service/web 9000:80 --address 0.0.0.0 > /dev/null 2>&1 &
sleep 2
curl -s -X POST -H 'Content-Type: application/json' -d '{"name": "Nico Robin", "bounty": 930000000}' localhost:9000/api/bounties
```{{exec}}

</details>
