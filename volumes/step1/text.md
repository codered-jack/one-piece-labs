A file written inside a container disappears with it. Try it:

`docker run --name voyage1 alpine sh -c 'echo "Day 1: left Foosha Village" >> /logbook.txt'`{{exec}}

`docker rm voyage1`{{exec}}

`docker run --rm alpine cat /logbook.txt`{{exec}}

The last command fails: the new container starts fresh from the image.

Now do it properly. Create a volume named `logbook`. Then, from a container that's **removed when it finishes**, write `Day 1: left Foosha Village` to `logbook.txt` in that volume.

Press **Check** when it's done.

<br>

<details><summary>Tip</summary>

`docker volume create logbook` creates the volume. `-v logbook:/data` attaches it at `/data` inside the container, and `--rm` removes the container when it finishes.

</details>

<details><summary>Solution</summary>

```plain
docker volume create logbook
docker run --rm -v logbook:/data alpine sh -c 'echo "Day 1: left Foosha Village" >> /data/logbook.txt'
```{{exec}}

</details>
