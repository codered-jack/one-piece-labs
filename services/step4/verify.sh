#!/bin/bash
# Passes when a lookout pod runs in east-blue, and ~/far.txt holds a
# Den Den Mushi answer.
kubectl get pod lookout -n east-blue >/dev/null 2>&1 || exit 1
grep -Eq '^Purupurupuru! den-den-[a-z0-9]+-[a-z0-9]+ here\.$' /root/far.txt 2>/dev/null
