#!/bin/bash
# Passes when wanted:v2 prints Luffy's poster by default and Zoro's when given Zoro.
[ "$(docker run --rm wanted:v2 2>/dev/null)" = "WANTED: Luffy - bounty 1,000 berries" ] || exit 1
[ "$(docker run --rm wanted:v2 Zoro 2>/dev/null)" = "WANTED: Zoro - bounty 1,000 berries" ]
