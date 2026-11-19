Download the image `alpine` at tag `3.20`, **without running it**.

Then list the images on this machine:

`docker image ls`{{exec}}

Press **Check** when `alpine` with tag `3.20` is listed.

<br>

<details><summary>Tip</summary>

An image name has two halves, `name:tag`. `docker pull` downloads an image and does nothing else.

</details>

<details><summary>Solution</summary>

```plain
docker pull alpine:3.20
```{{exec}}

</details>
