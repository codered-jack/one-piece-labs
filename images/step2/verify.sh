#!/bin/bash
# Passes when ~/layers.txt holds exactly the layer count of python:3.12-alpine.
expected=$(docker image inspect -f '{{len .RootFS.Layers}}' python:3.12-alpine 2>/dev/null)
saved=$(tr -d '[:space:]' < /root/layers.txt 2>/dev/null)
[ -n "$expected" ] && [ "$saved" = "$expected" ]
