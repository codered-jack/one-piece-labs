The Bounty Board's code is in the public repository the labs use. Copy it into your home folder with `git clone`, then look at the Kubernetes files:

`ls ~/one-piece-labs/bounty-board/k8s`{{exec}}

You should see one manifest per part: `api.yaml`, `cache.yaml`, `db.yaml` and `web.yaml`.

Press **Check** when the code is there.

<br>

<details><summary>Tip</summary>

`git clone` takes the repository's address: `https://github.com/codered-jack/one-piece-labs`. Run it from your home folder, `~`.

</details>

<details><summary>Solution</summary>

```plain
cd ~
git clone https://github.com/codered-jack/one-piece-labs
ls ~/one-piece-labs/bounty-board/k8s
```{{exec}}

</details>
