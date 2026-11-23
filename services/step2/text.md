Call the Service by its name, from the lookout:

`kubectl exec lookout -- wget -qO- http://den-den`{{exec}}

Each answer names the copy that answered. Now call it **ten** times, and save all ten answers to `~/answers.txt`.

Press **Check** when they're saved. The check wants at least two different copies in the answers.

<br>

<details><summary>Tip</summary>

`for i in $(seq 1 10); do <command>; done` runs a command ten times. Put `> ~/answers.txt` after `done` to save everything the loop prints.

</details>

<details><summary>Solution</summary>

```plain
for i in $(seq 1 10); do kubectl exec lookout -- wget -qO- http://den-den; done > ~/answers.txt
cat ~/answers.txt
```{{exec}}

</details>
