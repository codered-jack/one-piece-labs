Share the current folder on port `8080`, **in the background**, so you can keep typing commands.

Then ask it for a page:

`curl localhost:8080`{{exec}}

You should see a list of the folder's files, written in HTML. If you're still in `ship`, the list includes `name.txt`.

The server prints a log line for each request. If the prompt looks broken, press Enter.

Press **Check** when the server answers.

<br>

<details><summary>Tip</summary>

`&` at the end of a command runs it in the background. Python has a small web server built in: `python3 -m http.server <port>`.

</details>

<details><summary>Solution</summary>

```plain
python3 -m http.server 8080 &
```{{exec}}

</details>
