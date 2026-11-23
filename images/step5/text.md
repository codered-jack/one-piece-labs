Remove the `scribble` container, then the `python:3.12-alpine` image.

Check what's left:

`docker ps -a; docker image ls`{{exec}}

Press **Check** when neither is listed.

<br>

<details><summary>Tip</summary>

`docker rm` removes a container, and `docker image rm` removes an image. Docker won't remove an image while a container uses it, even a stopped one. The error names that container, so remove it first.

</details>

<details><summary>Solution</summary>

```plain
docker rm scribble
docker image rm python:3.12-alpine
```{{exec}}

</details>
