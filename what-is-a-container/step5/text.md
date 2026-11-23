Inside napper, `sleep` is PID 1. The machine knows the same process by a different number.

Find the **PID of napper's `sleep`, as the machine sees it**. Save just that number to `~/napper.pid`.

Check what you saved:

`cat ~/napper.pid`{{exec}}

It should print one number, and nothing else. Press **Check** when it does.

<br>

<details><summary>Tip</summary>

`pgrep -af <text>` finds running processes whose command contains the text. It prints each one's PID, then its command:

```plain
pgrep -af "sleep 3600"
```{{exec}}

`docker inspect -f '{{.State.Pid}}' napper` asks Docker for the same number.

</details>

<details><summary>Solution</summary>

Without `-a`, `pgrep` prints only the PID. `-x` makes it match the whole command exactly, so no other process sneaks in:

```plain
pgrep -xf "sleep 3600" > ~/napper.pid
```{{exec}}

</details>
