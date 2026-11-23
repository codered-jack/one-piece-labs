#!/bin/bash
# Passes when ~/reply.txt holds the Den Den Mushi's answer.
[ "$(cat /root/reply.txt 2>/dev/null)" = "Purupurupuru! den-den here." ]
