#!/bin/bash
# Passes when ~/container-kernel.txt holds exactly the machine's kernel version.
saved=$(tr -d '[:space:]' < /root/container-kernel.txt 2>/dev/null)
[ -n "$saved" ] && [ "$saved" = "$(uname -r)" ]
