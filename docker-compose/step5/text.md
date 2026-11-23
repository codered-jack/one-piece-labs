Time to clear the harbor: take the app down **and** delete its volume, so the logbook goes too. Then look for what's left:

`docker compose ps -a`{{exec}}

`docker volume ls`{{exec}}

`docker network ls`{{exec}}

No containers, no `harbor_logbook` volume, and no `harbor_default` network.

Press **Check** when they're all gone.

<br>

<details><summary>Tip</summary>

It's `docker compose down` with one more flag, `-v`, for volumes.

</details>

<details><summary>Solution</summary>

```plain
cd ~/harbor
docker compose down -v
```{{exec}}

</details>
