A visitor may look at the crew list, but not change it.

Run a container named `visitor` **in the background**, with `~/wanted` attached **read-only** at `/app`. Let it run `sleep 100000`.

Then check both sides: reading works, writing doesn't.

`docker exec visitor cat /app/crew.txt`{{exec}}

`docker exec visitor sh -c 'echo Usopp > /app/crew.txt'`{{exec}}

The second command fails with `Read-only file system`, and `~/wanted/crew.txt` still says `Zoro`.

Press **Check** when `visitor` is running.

<br>

<details><summary>Tip</summary>

Add `:ro` at the end of the mount: `-v ~/wanted:/app:ro`.

</details>

<details><summary>Solution</summary>

```plain
docker run -d --name visitor -v ~/wanted:/app:ro python:3.12-alpine sleep 100000
```{{exec}}

</details>
