First, wait for the setup to finish. It installs Compose, and prints `ready` when it's done:

`until [ -f ~/.setup-done ]; do sleep 2; done; echo ready`{{exec}}

The Bounty Board's code is in the public repository the labs use. Copy it into your home folder with `git clone`, then look at what's there:

`ls ~/one-piece-labs/bounty-board`{{exec}}

You should see `compose.yaml`, and one folder per part: `api`, `db`, `web`.

Press **Check** when the code is there.

<br>

<details><summary>Tip</summary>

`git clone` takes the repository's address: `https://github.com/codered-jack/one-piece-labs`. Run it from your home folder, `~`.

</details>

<details><summary>Solution</summary>

```plain
cd ~
git clone https://github.com/codered-jack/one-piece-labs
```{{exec}}

</details>
