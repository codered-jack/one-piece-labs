#!/bin/bash
# Passes when the cluster's containerd has all three Bounty Board images.
images=$(ctr -n k8s.io images ls -q 2>/dev/null)
for part in web api db; do
  printf '%s\n' "$images" | grep -q "bounty-board-$part:1.0$" || exit 1
done
