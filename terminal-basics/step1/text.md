Make a folder called `ship` in your home folder. Go into it, and write `Going Merry` into a file called `name.txt`.

Then check where you are, and what the file says:

`pwd`{{exec}}

`cat name.txt`{{exec}}

`pwd` should print `/root/ship`, and `cat` should print `Going Merry`. Press **Check** when they do.

<br>

<details><summary>Tip</summary>

`mkdir` makes a folder, and `cd` goes into it. `echo "some text" > file` writes text into a file.

</details>

<details><summary>Solution</summary>

```plain
mkdir ~/ship
cd ~/ship
echo "Going Merry" > name.txt
```{{exec}}

</details>
