Time to clear the board: take the app down **and** delete its volume, so the data goes too. Then look for what's left:

`docker compose ps -a`{{exec}}

`docker volume ls`{{exec}}

No containers, and no `bounty-board_bounty-data` volume. Start the app again some day, and it comes back with only the five bounties from `db/init.sql`.

Press **Check** when the containers and the volume are gone.

<br>

<details><summary>Tip</summary>

It's `docker compose down` with one more flag, `-v`, for volumes.

</details>

<details><summary>Solution</summary>

```plain
docker compose down -v
```{{exec}}

</details>
