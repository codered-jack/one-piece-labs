Stop every server you started. Afterwards, nothing should listen on `8080`, `9090` or `7070`.

`jobs` lists the servers this terminal started:

`jobs`{{exec}}

Stop each one with `kill %<number>`. Then check that the ports are free:

`ss -ltnp`{{exec}}

Press **Check** when none of the three ports is listed.

<br>

<details><summary>Tip</summary>

When a job stops, the next job you start can reuse its number. So read the numbers from `jobs`, instead of guessing.

A server started in another terminal tab isn't in this tab's `jobs`. Stop it by its PID instead, with `kill <PID>`.

</details>

<details><summary>Solution</summary>

`jobs -p` prints the PID of every background job. `$(...)` puts those PIDs after `kill`, so this stops them all at once:

```plain
kill $(jobs -p)
```{{exec}}

</details>
