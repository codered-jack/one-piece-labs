Build the three images, from the folders `web`, `api` and `db`, in `~/one-piece-labs/bounty-board`. Name them `bounty-board-web:1.0`, `bounty-board-api:1.0` and `bounty-board-db:1.0`.

The first build downloads its base image, so give it a minute.

The cluster can't see Docker's images. It keeps its own, in **containerd**, under the name `k8s.io`. So copy the images over: `docker save` writes images out as one stream, and `ctr` reads that stream into containerd.

`docker save bounty-board-web:1.0 bounty-board-api:1.0 bounty-board-db:1.0 | ctr -n k8s.io images import -`{{exec}}

The `-` at the end means "read from the pipe". Then check that the cluster has them:

`ctr -n k8s.io images ls -q | grep bounty-board`{{exec}}

Press **Check** when all three are listed.

<br>

<details><summary>Tip</summary>

`docker build -t <name>:<tag> <folder>` builds an image from the folder's `Dockerfile`. Run it three times, from `~/one-piece-labs/bounty-board`.

</details>

<details><summary>Solution</summary>

```plain
cd ~/one-piece-labs/bounty-board
docker build -t bounty-board-web:1.0 web
docker build -t bounty-board-api:1.0 api
docker build -t bounty-board-db:1.0 db
docker save bounty-board-web:1.0 bounty-board-api:1.0 bounty-board-db:1.0 | ctr -n k8s.io images import -
ctr -n k8s.io images ls -q | grep bounty-board
```{{exec}}

</details>
