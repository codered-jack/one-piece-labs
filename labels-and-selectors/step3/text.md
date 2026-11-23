A selector picks pods by their labels. List the Den Den Mushi:

`kubectl get pods -l app=den-den`{{exec}}

Now find every pod in `sea=east-blue`, whatever its `app`. Save their names to `~/east-blue.txt`, one per line.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`-l sea=east-blue` picks them. `-o name` prints only the names, one per line, as `pod/<name>`. The check accepts names with or without `pod/`.

</details>

<details><summary>Solution</summary>

```plain
kubectl get pods -l sea=east-blue -o name > ~/east-blue.txt
cat ~/east-blue.txt
```{{exec}}

</details>
