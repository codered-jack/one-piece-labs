Containers on the default network can't call each other by name. Try it: start a server, then call it by name from a second container:

`docker run -d --name test-den python:3.12-alpine python3 -m http.server 8000`{{exec}}

`docker run --rm alpine wget -qO- http://test-den:8000`{{exec}}

It fails with `bad address`. Remove the test server:

`docker rm -f test-den`{{exec}}

On a network you create, names work. Create a network named `fleet`, and list your networks:

`docker network ls`{{exec}}

Press **Check** when `fleet` is in the list.

<br>

<details><summary>Tip</summary>

`docker network create` takes the new network's name.

</details>

<details><summary>Solution</summary>

```plain
docker network create fleet
```{{exec}}

</details>
