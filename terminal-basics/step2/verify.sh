#!/bin/bash
# Passes when ~/server.pid holds exactly the PID listening on port 8080.
listener=$(ss -ltnpH 'sport = :8080' | grep -o 'pid=[0-9]*' | head -n 1 | cut -d= -f2)
saved=$(tr -d '[:space:]' < /root/server.pid 2>/dev/null)
[ -n "$listener" ] && [ "$saved" = "$listener" ]
