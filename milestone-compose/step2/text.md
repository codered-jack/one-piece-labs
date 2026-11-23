Go into the app's folder. Compose looks for `compose.yaml` in the folder you're in:

`cd ~/one-piece-labs/bounty-board`{{exec}}

Now start all four parts **in the background**, building the two images first. The first build takes a minute or so.

Then list the parts:

`docker compose ps`{{exec}}

All four should be `Up`, and `db` should say `(healthy)`. Ask the board's health page:

`curl -s localhost:9000/api/health`{{exec}}

Want to see the page itself? [Open port 9000]({{TRAFFIC_HOST1_9000}}) in a new browser tab.

Press **Check** when all four parts are up and healthy.

<br>

<details><summary>Tip</summary>

It's `docker compose up`, with `-d` to run in the background and `--build` to build the images first. If the health page doesn't answer yet, wait a few seconds: `db` needs a moment to get ready.

</details>

<details><summary>Solution</summary>

```plain
docker compose up -d --build
```{{exec}}

</details>
