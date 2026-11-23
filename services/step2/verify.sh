#!/bin/bash
# Passes when ~/answers.txt holds at least 10 Den Den Mushi answers, from at
# least 2 different copies.
[ -f /root/answers.txt ] || exit 1
answers=$(grep -E '^Purupurupuru! den-den-[a-z0-9]+-[a-z0-9]+ here\.$' /root/answers.txt)
[ "$(printf '%s\n' "$answers" | grep -c .)" -ge 10 ] || exit 1
[ "$(printf '%s\n' "$answers" | sort -u | wc -l)" -ge 2 ]
