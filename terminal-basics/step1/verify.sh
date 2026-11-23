#!/bin/bash
# Passes when ~/ship/name.txt holds the line "Going Merry".
[ "$(cat /root/ship/name.txt 2>/dev/null)" = "Going Merry" ]
