# Start a web server

Serve the current folder on port `8080`, **in the background**, so you get your prompt back.

Then be the client and ask it for a page:

`curl localhost:8080`{{exec}}

You should see the folder listing as HTML. The server logs each request into your terminal; if the prompt looks broken, press Enter.

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
