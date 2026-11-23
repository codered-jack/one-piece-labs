#!/bin/bash
# Passes when ~/reason.txt holds a liveness event: the restart ("failed
# liveness probe, will be restarted") or the failed check ("Liveness probe
# failed").
grep -qiE "failed liveness probe|liveness probe failed" /root/reason.txt 2>/dev/null
