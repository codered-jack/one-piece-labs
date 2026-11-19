#!/bin/bash
# Passes when ~/diff.txt matches what docker diff reports for scribble right now.
current=$(docker diff scribble 2>/dev/null)
[ -n "$current" ] && [ "$(cat /root/diff.txt 2>/dev/null)" = "$current" ]
