Pull `python:3.12-alpine`, then look at the steps that built it, newest first:

`docker history python:3.12-alpine`{{exec}}

Steps with a size of `0B` only record a setting and add no files, so they aren't layers.

Save **the number of layers** the image has to `~/layers.txt`, just the number. Check what you saved:

`cat ~/layers.txt`{{exec}}

Press **Check** when it prints one number.

<br>

<details><summary>Tip</summary>

`docker image inspect` prints a long report about an image, and `-f` picks one value out of it. The layers are listed under `RootFS.Layers`, and `len` counts them:

```plain
docker image inspect -f '{{len .RootFS.Layers}}' python:3.12-alpine
```{{exec}}

</details>

<details><summary>Solution</summary>

```plain
docker pull python:3.12-alpine
docker image inspect -f '{{len .RootFS.Layers}}' python:3.12-alpine > ~/layers.txt
```{{exec}}

</details>
