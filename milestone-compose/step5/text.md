Take one part away: **stop** only the `cache` service. Then read the board, from the page or the terminal:

`curl -s localhost:9000/api/bounties`{{exec}}

It still works, and `source` at the end now always says `database`. Ask the health page, with `-i` to see the status code:

`curl -si localhost:9000/api/health`{{exec}}

`503 SERVICE UNAVAILABLE`, with the cache `down`. Losing the cache made the board slower, but didn't stop it.

Press **Check** when the cache is stopped and the board still answers.

<br>

<details><summary>Tip</summary>

`docker compose stop` takes the name of a service from `compose.yaml`. Run it in `~/one-piece-labs/bounty-board`.

</details>

<details><summary>Solution</summary>

```plain
cd ~/one-piece-labs/bounty-board
docker compose stop cache
```{{exec}}

</details>
