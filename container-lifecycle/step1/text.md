The lookout is a small shell loop: it counts up, prints a report, waits 2 seconds, and does it again, forever:

```plain
sh -c 'i=0; while true; do i=$((i+1)); echo "Lookout report $i: all clear"; sleep 2; done'
```

Run it in an `alpine` container:

- in the background
- named `lookout`

Then check that it's running:

`docker ps`{{exec}}

Press **Check** when `lookout` shows as `Up`.

<br>

<details><summary>Tip</summary>

`-d` runs a container in the background, and `--name` names it. The image name goes before the command the container runs.

</details>

<details><summary>Solution</summary>

```plain
docker run -d --name lookout alpine sh -c 'i=0; while true; do i=$((i+1)); echo "Lookout report $i: all clear"; sleep 2; done'
```{{exec}}

</details>
