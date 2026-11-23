Run a container from the `alpine` image that prints `ahoy`.

The first run downloads `alpine` before it prints anything. Run the same command again, and it prints `ahoy` straight away. The image is already on the machine.

Press **Check** when you've seen `ahoy`.

<br>

<details><summary>Tip</summary>

`docker run <image> <command>` starts a container from the image, and runs the command inside it. Check looks for the stopped container afterwards, so don't add `--rm`.

</details>

<details><summary>Solution</summary>

```plain
docker run alpine echo ahoy
```{{exec}}

</details>
