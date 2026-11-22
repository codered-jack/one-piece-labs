#!/bin/bash
# Passes when ~/reports.txt holds exactly 3 lines, each one a lookout report.
[ -f /root/reports.txt ] || exit 1
[ "$(grep -c . /root/reports.txt)" -eq 3 ] || exit 1
[ "$(grep -cE '^Lookout report [0-9]+: all clear$' /root/reports.txt)" -eq 3 ]
