#!/bin/bash
# Killercoda's ubuntu image ships Docker without the Compose plugin. Installs
# a pinned Compose release as a CLI plugin, checks its SHA-256 against the
# release's checksum file, and touches /root/.setup-done only when
# `docker compose version` works, so step 1 never passes on a broken install.
set -euo pipefail

COMPOSE_VERSION=v5.8.0
PLUGIN_DIR=/usr/local/lib/docker/cli-plugins
ASSET="docker-compose-linux-$(uname -m)"
BASE_URL="https://github.com/docker/compose/releases/download/${COMPOSE_VERSION}"

workdir=$(mktemp -d)
cd "$workdir"
curl -fsSL --retry 5 -o "$ASSET" "$BASE_URL/$ASSET"
curl -fsSL --retry 5 -o "$ASSET.sha256" "$BASE_URL/$ASSET.sha256"
sha256sum -c "$ASSET.sha256"

mkdir -p "$PLUGIN_DIR"
install -m 0755 "$ASSET" "$PLUGIN_DIR/docker-compose"
rm -rf "$workdir"

docker compose version
touch /root/.setup-done
