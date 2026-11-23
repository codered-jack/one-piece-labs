Your home folder has a small app, `app.py`. Have a look:

`cat ~/app.py`{{exec}}

It reads its port from the `PORT` environment variable. When `PORT` isn't set, it uses `8000`.

Start `app.py` in the background, so it listens on port `7070`. Don't edit the file. Then ask it for a page:

`curl localhost:7070`{{exec}}

It should answer `Ahoy from port 7070!`. Press **Check** when it does.

<br>

<details><summary>Tip</summary>

`NAME=value command` sets an environment variable for that one command. Put it on the same line, in front of `python3`.

</details>

<details><summary>Solution</summary>

```plain
cd ~
PORT=7070 python3 app.py &
```{{exec}}

</details>
