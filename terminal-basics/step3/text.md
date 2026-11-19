Start a second server, on port `9090`, bound to `127.0.0.1` (localhost) only.

It answers when you ask from this machine through localhost:

`curl localhost:9090`{{exec}}

Now ask through the machine's own address instead. `hostname -I` prints it, and this command uses the first one:

`curl $(hostname -I | awk '{print $1}'):9090`{{exec}}

That one fails with `Connection refused`: the server only listens on localhost, so nothing else can reach it.

Fix it: stop the localhost server, and start it again on `0.0.0.0`. Run the second `curl` again; this time it answers.

Press **Check** when it does.

<br>

<details><summary>Tip</summary>

`--bind <address>` chooses the address `http.server` listens on. `jobs` lists your background servers with their job numbers, and `kill %<number>` stops one.

</details>

<details><summary>Solution</summary>

Start the localhost-only server:

```plain
python3 -m http.server 9090 --bind 127.0.0.1 &
```{{exec}}

Find its job number:

```plain
jobs
```{{exec}}

Stop it with that number. If `jobs` lists it as job 2:

```plain
kill %2
```{{copy}}

Start it again on every address:

```plain
python3 -m http.server 9090 --bind 0.0.0.0 &
```{{exec}}

</details>
