Start a second server, on port `9090`. Bind it to `127.0.0.1`, so it listens on localhost only.

Ask it for a page through localhost. It answers:

`curl localhost:9090`{{exec}}

Now ask through the machine's network address instead:

`curl $(hostname -I | awk '{print $1}'):9090`{{exec}}

`hostname -I` prints the machine's addresses, and `awk '{print $1}'` keeps the first one. `$(...)` puts that address into the `curl` command.

This time `curl` fails with `Failed to connect`. The server listens on localhost only, so it doesn't answer calls sent to the network address.

Now fix it. Stop the localhost server, and start it again on `0.0.0.0`. Then run the second `curl` again. This time it answers.

Press **Check** when it does.

<br>

<details><summary>Tip</summary>

`--bind <address>` chooses the address `http.server` listens on. `jobs` lists your background servers with their job numbers. `kill %<number>` stops one.

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
