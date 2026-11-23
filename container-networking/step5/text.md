This lighthouse publishes its port, but listens only on `127.0.0.1` inside its container:

`docker run -d --name lighthouse -p 9090:8000 python:3.12-alpine sh -c 'echo "The lighthouse is lit." > index.html && python3 -m http.server 8000 --bind 127.0.0.1'`{{exec}}

`curl localhost:9090`{{exec}}

The call fails. The server itself is fine:

`docker exec lighthouse wget -qO- http://127.0.0.1:8000`{{exec}}

`-p` delivers your call to the container's network address, not to its `localhost`, so the lighthouse never hears it. Fix it: run `lighthouse` again so that `curl localhost:9090` answers.

Press **Check** when it does.

<br>

<details><summary>Tip</summary>

A server must listen on every address, `0.0.0.0`, to be reached through `-p`. Remove the old lighthouse first.

</details>

<details><summary>Solution</summary>

```plain
docker rm -f lighthouse
docker run -d --name lighthouse -p 9090:8000 python:3.12-alpine sh -c 'echo "The lighthouse is lit." > index.html && python3 -m http.server 8000 --bind 0.0.0.0'
```{{exec}}

</details>
