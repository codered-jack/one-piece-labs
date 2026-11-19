#!/bin/bash
# Passes when wanted:v1 is Python 3.12 on Alpine and prints Luffy's default poster.
docker run --rm --entrypoint cat wanted:v1 /etc/alpine-release >/dev/null 2>&1 || exit 1
docker run --rm --entrypoint python3 wanted:v1 --version 2>/dev/null | grep -q '^Python 3\.12\.' || exit 1
[ "$(docker run --rm wanted:v1 2>/dev/null)" = "WANTED: Luffy - bounty 1,000 berries" ]
