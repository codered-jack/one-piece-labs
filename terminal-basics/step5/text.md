# Clean up

Stop every server you started, so nothing is listening on `8080`, `9090` or `7070`.

`jobs` lists the servers this terminal started:

`jobs`{{exec}}

Stop each one with `kill %<number>`, then confirm the ports are free:

`ss -ltnp`{{exec}}

Press **Check** when none of the three ports is listed.

<br>

<details><summary>Tip</summary>

A stopped job's number gets reused by the next job you start, so read the numbers from `jobs` rather than guessing. A server started in another terminal tab won't be in this tab's `jobs`; stop it by PID instead, with `kill <PID>`.

</details>

<details><summary>Solution</summary>

`jobs -p` prints the PID of every background job in this terminal, so this stops them all at once:

```plain
kill $(jobs -p)
```{{exec}}

</details>
