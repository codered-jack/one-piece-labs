Take one part away: **stop** only the `cache` service. Then read the board:

`curl -s localhost:9000/api/bounties | grep -o '"source":"[a-z]*"'`{{exec}}

It still works, now straight from the `database`. Ask the health page:

`curl -s localhost:9000/api/health`{{exec}}

The health page reports the cache `down`. Losing the cache made the board slower, but didn't stop it.

Press **Check** when the cache is stopped and the board still answers.

<br>

<details><summary>Tip</summary>

`docker compose stop` takes the name of a service from `compose.yaml`.

</details>

<details><summary>Solution</summary>

```plain
docker compose stop cache
```{{exec}}

</details>
