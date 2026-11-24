#!/bin/bash
# Passes when ~/harbor/compose.yaml is valid and has a den-den service that
# runs python:3.12-alpine and publishes port 8000 as 9000.
[ -f /root/.setup-done ] || exit 1
config=$(docker compose -f /root/harbor/compose.yaml config 2>/dev/null) || exit 1
docker compose -f /root/harbor/compose.yaml config --services 2>/dev/null | grep -qx den-den || exit 1
echo "$config" | grep -q 'image: python:3.12-alpine' || exit 1
echo "$config" | grep -q 'target: 8000' || exit 1
echo "$config" | grep -q 'published: "9000"'
