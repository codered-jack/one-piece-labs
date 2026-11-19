Start a container named `napper` that runs `sleep 3600`, **in the background**, so you get your prompt back.

Then list the running containers:

`docker ps`{{exec}}

Press **Check** when `napper` is listed.

<br>

<details><summary>Tip</summary>

`-d` runs a container in the background, like `&` does for a command. `--name napper` gives it a name, so you don't need its ID.

</details>

<details><summary>Solution</summary>

```plain
docker run -d --name napper alpine sleep 3600
```{{exec}}

</details>
