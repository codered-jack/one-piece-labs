Start the Den Den Mushi: a container named `den-den`, **on the `fleet` network**, in the background. This command makes it answer on port 8000 with one line; add what's missing:

```plain
docker run -d --name den-den python:3.12-alpine sh -c 'echo "Purupurupuru! Den Den Mushi here." > index.html && python3 -m http.server 8000'
```

Then call it from inside its own container:

`docker exec den-den wget -qO- http://127.0.0.1:8000`{{exec}}

Press **Check** when it answers.

<br>

<details><summary>Tip</summary>

`--network fleet` puts a container on `fleet`. Put it before the image name.

</details>

<details><summary>Solution</summary>

```plain
docker run -d --name den-den --network fleet python:3.12-alpine sh -c 'echo "Purupurupuru! Den Den Mushi here." > index.html && python3 -m http.server 8000'
```{{exec}}

</details>
