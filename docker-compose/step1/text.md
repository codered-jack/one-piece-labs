First, wait for the setup to finish. It installs Compose, and prints `ready` when it's done:

`until [ -f ~/.setup-done ]; do sleep 2; done; echo ready`{{exec}}

Check that Compose is here:

`docker compose version`{{exec}}

Make a folder called `harbor`, and go into it:

`mkdir -p ~/harbor && cd ~/harbor`{{exec}}

In it, write a `compose.yaml` with one service, `den-den`, that does what this command did in the networking lab:

```plain
docker run -d --name den-den -p 9000:8000 python:3.12-alpine sh -c 'echo "Purupurupuru! Den Den Mushi here." > index.html && python3 -m http.server 8000'
```

Then ask Compose to read it back:

`docker compose config`{{exec}}

Press **Check** when it prints your file back with no error.

<br>

<details><summary>Tip</summary>

Under `services:` goes `den-den:`. Under that go three settings:

- `image:`
- `command:`, everything after the image name
- `ports:`, a list with one item, `"9000:8000"`

Indent with spaces, never tabs.

</details>

<details><summary>Solution</summary>

This writes the file without an editor:

```plain
cd ~/harbor
cat > compose.yaml <<'EOF'
services:
  den-den:
    image: python:3.12-alpine
    command: sh -c 'echo "Purupurupuru! Den Den Mushi here." > index.html && python3 -m http.server 8000'
    ports:
      - "9000:8000"
EOF
```{{exec}}

</details>
