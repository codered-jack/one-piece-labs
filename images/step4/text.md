`docker diff` lists what a container changed in its writable layer: `A` for added, `C` for changed, `D` for deleted.

Save what `scribble` changed, as `docker diff` reports it, to `~/diff.txt`. Then read it:

`cat ~/diff.txt`{{exec}}

Press **Check** when it lists `/note.txt`.

<br>

<details><summary>Tip</summary>

`docker diff <container>` prints the changes. Save them with `>`.

</details>

<details><summary>Solution</summary>

```plain
docker diff scribble > ~/diff.txt
```{{exec}}

</details>
