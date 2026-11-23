A bind mount attaches a folder from this machine. Run `wanted.py` from `~/wanted` with plain `python:3.12-alpine`, which has never seen it:

`docker run --rm -v ~/wanted:/app python:3.12-alpine python3 /app/wanted.py Luffy`{{exec}}

Now keep a container running with the folder attached. Run a container named `deck` **in the background**, with `~/wanted` attached at `/app`. Let it run `sleep 100000`, so it stays up.

Then, **on this machine** (not in the container), create `~/wanted/crew.txt` containing `Zoro`, and read it from inside `deck`:

`docker exec deck cat /app/crew.txt`{{exec}}

Press **Check** when it prints `Zoro`.

<br>

<details><summary>Tip</summary>

`-d` runs a container in the background, and `-v ~/wanted:/app` attaches the folder. Your terminal turns `~/wanted` into the full path, `/root/wanted`, so Docker treats it as a folder, not a volume name.

</details>

<details><summary>Solution</summary>

```plain
docker run -d --name deck -v ~/wanted:/app python:3.12-alpine sleep 100000
echo Zoro > ~/wanted/crew.txt
```{{exec}}

</details>
