#!/bin/bash
# Passes when ~/napper.pid holds exactly the machine's PID for napper's main process.
pid=$(docker inspect -f '{{.State.Pid}}' napper 2>/dev/null)
saved=$(tr -d '[:space:]' < /root/napper.pid 2>/dev/null)
[ -n "$pid" ] && [ "$pid" != "0" ] && [ "$saved" = "$pid" ]
