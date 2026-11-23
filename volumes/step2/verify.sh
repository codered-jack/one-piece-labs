#!/bin/bash
# Passes when the ship container is gone and the logbook still starts with the
# Day 1 entry and ends with the Day 2 entry.
[ -z "$(docker ps -aq --filter name='^ship$')" ] || exit 1
log=$(docker run --rm -v logbook:/logbook alpine cat /logbook/logbook.txt 2>/dev/null) || exit 1
[ "$(head -n 1 <<< "$log")" = "Day 1: left Foosha Village" ] || exit 1
[ "$(tail -n 1 <<< "$log")" = "Day 2: met Zoro" ]
