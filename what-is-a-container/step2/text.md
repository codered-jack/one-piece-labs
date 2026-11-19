First, check which Linux the machine itself runs:

`cat /etc/os-release`{{exec}}

Now print the same file from inside an `alpine` container, and save what it prints to `~/container-os.txt` **on the machine**. Then look at what you saved:

`cat ~/container-os.txt`{{exec}}

Press **Check** when the file says Alpine.

<br>

<details><summary>Tip</summary>

`>` saves a command's output to a file. Put it after the whole `docker run` command: the container prints, and your shell on the machine writes the file.

</details>

<details><summary>Solution</summary>

```plain
docker run alpine cat /etc/os-release > ~/container-os.txt
```{{exec}}

</details>
