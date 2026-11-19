Run a container named `scribble` from `alpine` that writes `ahoy` to the file `/note.txt` **inside the container**.

Then look for the file from a brand-new container:

`docker run alpine cat /note.txt`{{exec}}

It isn't there: the file went into scribble, not into the image. Press **Check** when scribble has written its file.

<br>

<details><summary>Tip</summary>

`>` is a shell feature, so it needs a shell inside the container. `sh -c '...'` runs the quoted command line with Alpine's shell. Without it, the `>` runs on the machine instead.

</details>

<details><summary>Solution</summary>

```plain
docker run --name scribble alpine sh -c 'echo ahoy > /note.txt'
```{{exec}}

</details>
