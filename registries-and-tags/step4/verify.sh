#!/bin/bash
# Passes when ~/pinned.txt holds one digest-pinned wanted name, and that exact
# image prints Luffy's 1,000-berry poster, so it's version 1.0's digest.
ref=$(tr -d '[:space:]' < /root/pinned.txt 2>/dev/null)
[[ "$ref" =~ ^localhost:5000/wanted@sha256:[0-9a-f]{64}$ ]] || exit 1
[ "$(docker run --rm "$ref" 2>/dev/null)" = "WANTED: Luffy - bounty 1,000 berries" ]
