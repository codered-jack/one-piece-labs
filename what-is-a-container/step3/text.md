`uname -r` prints the version of the kernel that's running. Save the version an `alpine` container reports to `~/container-kernel.txt`.

Then compare it with the machine's own:

`cat ~/container-kernel.txt; uname -r`{{exec}}

Alpine inside, Ubuntu outside. Do the two lines match? Press **Check** to find out.

<br>

<details><summary>Tip</summary>

Same pattern as the last step: run `uname -r` in a container, and save its output with `>`.

</details>

<details><summary>Solution</summary>

```plain
docker run alpine uname -r > ~/container-kernel.txt
```{{exec}}

The two lines are identical: a container has no kernel of its own. Every container on this machine shares the machine's kernel.

</details>
