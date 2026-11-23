#!/bin/bash
# Passes when ~/reply.txt holds den-den's answer.
[ "$(cat /root/reply.txt 2>/dev/null)" = "Purupurupuru! Den Den Mushi here." ]
