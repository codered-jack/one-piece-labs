#!/bin/bash
# Passes when, in the registry, 1.1 and latest are the same image with the
# 30,000,000 bounty, and 1.0 is a different image that still gives 1,000.
digest_of() {
  curl -fsI --max-time 3 \
    -H 'Accept: application/vnd.oci.image.index.v1+json, application/vnd.oci.image.manifest.v1+json, application/vnd.docker.distribution.manifest.list.v2+json, application/vnd.docker.distribution.manifest.v2+json' \
    "http://localhost:5000/v2/wanted/manifests/$1" | tr -d '\r' | awk 'tolower($1) == "docker-content-digest:" { print $2 }'
}
old=$(digest_of 1.0)
new=$(digest_of 1.1)
latest=$(digest_of latest)
[ -n "$old" ] && [ -n "$new" ] || exit 1
[ "$latest" = "$new" ] && [ "$old" != "$new" ] || exit 1
[ "$(docker run --rm "localhost:5000/wanted@$new" 2>/dev/null)" = "WANTED: Luffy - bounty 30,000,000 berries" ] || exit 1
[ "$(docker run --rm "localhost:5000/wanted@$old" 2>/dev/null)" = "WANTED: Luffy - bounty 1,000 berries" ]
