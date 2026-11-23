#!/bin/bash
# Passes when the board is back to its first 5 bounties, as the new database
# pod started empty, and ~/count.txt says 5.
[ "$(tr -d '[:space:]' < /root/count.txt 2>/dev/null)" = "5" ] || exit 1
list=$(kubectl exec -n bounty-board deploy/web -- wget -qO- http://127.0.0.1/api/bounties 2>/dev/null)
[ "$(printf '%s' "$list" | grep -o '"id"' | wc -l)" -eq 5 ]
