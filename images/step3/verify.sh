#!/bin/bash
# Passes when the container scribble holds /note.txt containing ahoy.
# docker cp reads from stopped containers too, and streams the file as a tar archive.
content=$(docker cp scribble:/note.txt - 2>/dev/null | tar -xO 2>/dev/null)
[ "$content" = "ahoy" ]
