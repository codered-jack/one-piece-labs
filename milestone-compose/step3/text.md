[Open the Bounty Board]({{TRAFFIC_HOST1_9000}}) in a new browser tab. Under the title, it says where the list came from: **Served from the database**. Reload it, and it says **Served from the cache**: the API kept a copy for 30 seconds.

The terminal can ask the API too. The answer is JSON, and its last key, `source`, says the same thing:

`curl -s localhost:9000/api/bounties`{{exec}}

Now post a bounty on the page: **Nico Robin**, for **930000000** berries. Then read the board again:

`curl -s localhost:9000/api/bounties`{{exec}}

Press **Check** when Nico Robin is on the board.

<br>

<details><summary>Tip</summary>

Type the name and the bounty in the form at the top of the page, and press **Post a bounty**. Type the bounty as digits only, with no commas.

</details>

<details><summary>Solution</summary>

The page sends the API this JSON with `POST`. You can send it from the terminal too:

- `-X POST` sends data, instead of only asking for it.
- `-H` says the data is JSON.
- `-d` is the data itself.

```plain
curl -s -X POST -H 'Content-Type: application/json' -d '{"name": "Nico Robin", "bounty": 930000000}' localhost:9000/api/bounties
```{{exec}}

</details>
