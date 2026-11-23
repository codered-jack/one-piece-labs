#!/bin/bash
# Passes when the logbook volume exists and the first line of logbook.txt in it
# is the Day 1 entry.
docker volume inspect logbook >/dev/null 2>&1 || exit 1
[ "$(docker run --rm -v logbook:/logbook alpine head -n 1 /logbook/logbook.txt 2>/dev/null)" = "Day 1: left Foosha Village" ]
