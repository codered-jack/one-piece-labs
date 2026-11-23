Add a second service, `lookout`, to `compose.yaml`. It runs `alpine`, and this loop, which calls the Den Den Mushi every 2 seconds and adds each answer to a logbook:

```plain
sh -c 'while true; do wget -qO- http://den-den:8000 >> /logbook/calls.txt; sleep 2; done'
```

It needs:

- a volume called `logbook`, attached at `/logbook`
- to start after `den-den`

Run `up` again: Compose leaves `den-den` alone and adds what's new. Then watch the calls arrive, and read the logbook:

`docker compose logs --tail 3 den-den`{{exec}}

`docker compose exec lookout cat /logbook/calls.txt`{{exec}}

Press **Check** when the logbook has calls in it.

<br>

<details><summary>Tip</summary>

Under `lookout:` go `image:`, `command:`, `volumes:` (a list, with `logbook:/logbook`) and `depends_on:` (a list, with `den-den`). A named volume also needs a top-level `volumes:` with `logbook:` under it, at the same level as `services:`.

</details>

<details><summary>Solution</summary>

```plain
cd ~/harbor
cat > compose.yaml <<'EOF'
services:
  den-den:
    image: python:3.12-alpine
    command: sh -c 'echo "Purupurupuru! Den Den Mushi here." > index.html && python3 -m http.server 8000'
    ports:
      - "9000:8000"

  lookout:
    image: alpine
    command: sh -c 'while true; do wget -qO- http://den-den:8000 >> /logbook/calls.txt; sleep 2; done'
    volumes:
      - logbook:/logbook
    depends_on:
      - den-den

volumes:
  logbook:
EOF
docker compose up -d
```{{exec}}

</details>
