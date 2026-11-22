The lookout runs in the background, so its reports don't show up in your terminal. Read them:

`docker logs lookout`{{exec}}

Now save only its **last 3** lines to `~/reports.txt`, and look at the file:

`cat ~/reports.txt`{{exec}}

Press **Check** when the file holds 3 reports.

Want to watch the reports arrive? `docker logs -f lookout`{{exec}} follows the log. Press `Ctrl+C` to stop following; the lookout keeps running.

<br>

<details><summary>Tip</summary>

`docker logs --tail <number>` shows only the last lines. `>` sends a command's output into a file instead of the screen.

</details>

<details><summary>Solution</summary>

```plain
docker logs --tail 3 lookout > ~/reports.txt
```{{exec}}

</details>
