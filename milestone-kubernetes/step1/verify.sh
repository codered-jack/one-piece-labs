#!/bin/bash
# Passes when the Bounty Board's Kubernetes manifests and db/Dockerfile are in
# ~/one-piece-labs.
for f in k8s/api.yaml k8s/cache.yaml k8s/db.yaml k8s/web.yaml db/Dockerfile; do
  [ -f "/root/one-piece-labs/bounty-board/$f" ] || exit 1
done
