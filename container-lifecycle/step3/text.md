`docker exec` runs an extra command inside a running container. See what's running inside the lookout:

`docker exec lookout ps`{{exec}}

PID 1 is the lookout's loop; `ps` is the command you just added.

Now leave a note: create `/note.txt` **inside the lookout**, containing `ahoy`. Then read it back:

`docker exec lookout cat /note.txt`{{exec}}

Press **Check** when it prints `ahoy`.

<br>

<details><summary>Tip</summary>

Wrap the command in `sh -c '…'`. Without it, your own terminal handles the `>` and writes `note.txt` on this machine, not in the container.

</details>

<details><summary>Solution</summary>

```plain
docker exec lookout sh -c 'echo ahoy > /note.txt'
```{{exec}}

</details>
