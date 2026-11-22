Stop the lookout, then look at it:

`docker ps -a`{{exec}}

Its status should say `Exited (137)`: the loop ignored the request to stop, so Docker forced it after a few seconds.

Then start it again, and check its reports and your note:

`docker logs lookout`{{exec}}

`docker exec lookout cat /note.txt`{{exec}}

The count went back to 1, because `docker start` runs the main command again from the beginning. But it's the same container: the old reports are still in the log, and the note is still there. Press **Check** when the lookout is running again.

<br>

<details><summary>Tip</summary>

`docker stop <name>` stops a container and keeps it. `docker start <name>` starts a stopped container again.

</details>

<details><summary>Solution</summary>

```plain
docker stop lookout
docker start lookout
```{{exec}}

</details>
