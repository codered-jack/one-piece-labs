Start a registry container:

- named `registry`
- from the image `registry:2`
- running in the background
- reachable at `localhost:5000`

Then ask it what it holds:

`curl localhost:5000/v2/_catalog`{{exec}}

It should print `{"repositories":[]}`: a registry with nothing in it yet. Press **Check** when it does.

<br>

<details><summary>Tip</summary>

`-d` runs a container in the background. `-p 5000:5000` connects port 5000 on this machine to port 5000 in the container, where the registry listens.

</details>

<details><summary>Solution</summary>

```plain
docker run -d -p 5000:5000 --name registry registry:2
```{{exec}}

</details>
