#!/bin/bash
# Passes when the registry holds wanted:1.0 and that image prints Luffy's 1,000-berry poster.
# Running it by the digest the registry reports checks the pushed image itself.
digest=$(curl -fsI --max-time 3 \
  -H 'Accept: application/vnd.oci.image.index.v1+json, application/vnd.oci.image.manifest.v1+json, application/vnd.docker.distribution.manifest.list.v2+json, application/vnd.docker.distribution.manifest.v2+json' \
  http://localhost:5000/v2/wanted/manifests/1.0 | tr -d '\r' | awk 'tolower($1) == "docker-content-digest:" { print $2 }')
[ -n "$digest" ] || exit 1
[ "$(docker run --rm "localhost:5000/wanted@$digest" 2>/dev/null)" = "WANTED: Luffy - bounty 1,000 berries" ]
