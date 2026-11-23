Start everything in `compose.yaml`, **in the background**. Then list the app's containers:

`docker compose ps`{{exec}}

You should see `harbor-den-den-1`, `Up`. Compose made a network for it too:

`docker network ls`{{exec}}

Call the Den Den Mushi:

`curl localhost:9000`{{exec}}

Press **Check** when it answers.

<br>

<details><summary>Tip</summary>

It's `docker compose up`, with `-d` for the background, as in `docker run -d`. Run it in `~/harbor`, where `compose.yaml` is.

</details>

<details><summary>Solution</summary>

```plain
cd ~/harbor
docker compose up -d
```{{exec}}

</details>
