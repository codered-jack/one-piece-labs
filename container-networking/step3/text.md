First, fall into the localhost trap. Call `127.0.0.1` from a **new** container on `fleet`:

`docker run --rm --network fleet alpine wget -qO- http://127.0.0.1:8000`{{exec}}

`Connection refused`: the new container called its own `localhost`, and nothing listens there.

Now call `den-den` **by name** from a new container on `fleet`, and save its answer to `~/reply.txt`. Then read it:

`cat ~/reply.txt`{{exec}}

Press **Check** when it holds den-den's answer.

<br>

<details><summary>Tip</summary>

The caller needs `--network fleet` too, and the address is `http://den-den:8000`. Use `>` to save what `wget -qO-` prints.

</details>

<details><summary>Solution</summary>

```plain
docker run --rm --network fleet alpine wget -qO- http://den-den:8000 > ~/reply.txt
```{{exec}}

</details>
