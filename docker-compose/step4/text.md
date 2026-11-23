Take the app **down**, which removes both containers and the network. Then look for what's left:

`docker compose ps -a`{{exec}}

`docker volume ls`{{exec}}

No containers, but the `harbor_logbook` volume is still there. Bring the app back **up**, and read the logbook again:

`docker compose exec lookout cat /logbook/calls.txt`{{exec}}

The lookout is a brand-new container, but the calls from before are still in the logbook, with new ones below them.

Press **Check** when the app is back with its old logbook.

<br>

<details><summary>Tip</summary>

It's `docker compose down`, then the same `up -d` as before. Plain `down`, with no `-v`: that would delete the logbook.

Ran `down -v` by mistake? The old calls are gone for good, but you can carry on. Wait a few seconds, then run `down` and `up -d` once more.

</details>

<details><summary>Solution</summary>

```plain
cd ~/harbor
docker compose down
docker compose up -d
```{{exec}}

</details>
