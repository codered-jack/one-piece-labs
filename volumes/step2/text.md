This time, use a container with a name, so you can remove it yourself.

From a container named `ship`, add `Day 2: met Zoro` to the logbook. Then remove `ship`, and read the logbook from a brand-new container:

`docker run --rm -v logbook:/data alpine cat /data/logbook.txt`{{exec}}

Press **Check** when both days are there, and `ship` is gone.

<br>

<details><summary>Tip</summary>

Use `>>` to add a line. A single `>` would replace the whole file.

</details>

<details><summary>Solution</summary>

```plain
docker run --name ship -v logbook:/data alpine sh -c 'echo "Day 2: met Zoro" >> /data/logbook.txt'
docker rm ship
```{{exec}}

</details>
