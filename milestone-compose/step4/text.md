A storm hits: take the whole app **down**, which removes all four containers. Check that they're gone:

`docker compose ps`{{exec}}

An empty list. Now bring the app back **up** (no need to build again), and read the board:

`curl -s localhost:9000/api/bounties`{{exec}}

Nico Robin is still there: `down` removed the containers, but kept the volume with the data.

Press **Check** when the app is back with Nico Robin on the board.

<br>

<details><summary>Tip</summary>

It's `docker compose down`, then the same `up -d` as before. If the board doesn't answer yet, wait a few seconds for `db`.

</details>

<details><summary>Solution</summary>

```plain
docker compose down
docker compose up -d
```{{exec}}

</details>
