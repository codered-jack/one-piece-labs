Look at the app's Dockerfile, then build it as `wanted:v2`:

`cd ~/wanted && cat Dockerfile && docker build -t wanted:v2 .`{{exec}}

`wanted:v2` lives only on this machine. Give it a second name that includes your registry, `localhost:5000/wanted:1.0`, and push it.

Then ask the registry which tags it has for `wanted`:

`curl localhost:5000/v2/wanted/tags/list`{{exec}}

Press **Check** when it lists `1.0`.

<br>

<details><summary>Tip</summary>

`docker tag <existing name> <new name>` adds a name to an image without copying it. `docker push <name>` sends the image to the registry in its name.

</details>

<details><summary>Solution</summary>

```plain
docker tag wanted:v2 localhost:5000/wanted:1.0
docker push localhost:5000/wanted:1.0
```{{exec}}

</details>
