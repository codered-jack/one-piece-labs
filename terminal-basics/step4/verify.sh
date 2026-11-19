#!/bin/bash
# Passes when app.py answers on port 7070 and got that port from its PORT
# environment variable, so an edited app.py doesn't count.
pid=$(ss -ltnpH 'sport = :7070' | grep -o 'pid=[0-9]*' | head -n 1 | cut -d= -f2)
[ -n "$pid" ] || exit 1
tr '\0' '\n' < "/proc/$pid/cmdline" | grep -q 'app\.py$' || exit 1
tr '\0' '\n' < "/proc/$pid/environ" | grep -qx 'PORT=7070' || exit 1
curl -fs --max-time 3 http://localhost:7070 | grep -q 'port 7070'
