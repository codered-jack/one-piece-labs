Stop and remove `napper` in one go. Then list every container, stopped ones included:

`docker ps -a`{{exec}}

You'll still see the containers that ran `echo`, `cat` and `uname`. They stopped when their command finished, and they're harmless. Press **Check** when `napper` is gone.

<br>

<details><summary>Tip</summary>

`docker rm` removes a container, and `-f` stops it first if it's still running.

</details>

<details><summary>Solution</summary>

```plain
docker rm -f napper
```{{exec}}

</details>
