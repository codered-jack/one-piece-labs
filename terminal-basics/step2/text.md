Find the **PID** of the process listening on port `8080`, then save just that number to `~/server.pid`.

Check what you saved:

`cat ~/server.pid`{{exec}}

It should print one number and nothing else. Press **Check** when it does.

<br>

<details><summary>Tip</summary>

`ss -ltnp` lists every listening port. Send it through `grep` to keep only the line for port 8080, and look for `pid=` in that line:

```plain
ss -ltnp | grep :8080
```{{exec}}

`echo <number> > ~/server.pid` writes a number into the file.

</details>

<details><summary>Solution</summary>

Find the PID:

```plain
ss -ltnp | grep :8080
```{{exec}}

The end of the line looks like `users:(("python3",pid=4242,fd=3))`. Save your number, not 4242:

```plain
echo 4242 > ~/server.pid
```{{copy}}

</details>
