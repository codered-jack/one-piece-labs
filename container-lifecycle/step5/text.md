This container sets sail, hits a reef after 3 seconds, and exits with code `1`, an error:

```plain
sh -c 'echo "Setting sail..."; sleep 3; echo "Hit a reef!"; exit 1'
```

Run it in an `alpine` container, in the background, named `flaky`, with a **restart policy** that starts it again whenever it fails.

Wait about 10 seconds, then look at it:

`docker logs flaky`{{exec}}

`docker ps -a`{{exec}}

The log shows it setting sail again and again: Docker keeps bringing it back. Press **Check** when it has been restarted at least once.

<br>

<details><summary>Tip</summary>

`--restart on-failure` restarts a container whenever it exits with an error. Like `-d` and `--name`, it goes before the image name.

</details>

<details><summary>Solution</summary>

```plain
docker run -d --name flaky --restart on-failure alpine sh -c 'echo "Setting sail..."; sleep 3; echo "Hit a reef!"; exit 1'
```{{exec}}

</details>
