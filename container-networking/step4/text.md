Containers on `fleet` can call `den-den`, but this machine can't:

`curl localhost:9000`{{exec}}

Make `curl localhost:9000` reach den-den's port 8000. You can't add `-p` to a container that exists already, so remove `den-den` and start it again, **still on `fleet`**. Then try once more:

`curl localhost:9000`{{exec}}

Press **Check** when it answers.

<br>

<details><summary>Tip</summary>

`-p 9000:8000` connects port 9000 on this machine to port 8000 in the container. `docker rm -f den-den` removes the old one.

</details>

<details><summary>Solution</summary>

```plain
docker rm -f den-den
docker run -d --name den-den --network fleet -p 9000:8000 python:3.12-alpine sh -c 'echo "Purupurupuru! Den Den Mushi here." > index.html && python3 -m http.server 8000'
```{{exec}}

</details>
