#!/bin/bash
# Passes when .env still exists on the machine and a .dockerignore exists,
# yet wanted:v4 has wanted.py and no .env in /app, and still runs.
[ -f /root/wanted/.env ] || exit 1
[ -f /root/wanted/.dockerignore ] || exit 1
docker run --rm --entrypoint sh wanted:v4 -c 'test -f /app/wanted.py && test ! -e /app/.env' 2>/dev/null || exit 1
docker run --rm wanted:v4 Zoro 2>/dev/null | grep -q '^WANTED: Zoro - bounty '
