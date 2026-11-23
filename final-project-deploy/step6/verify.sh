#!/bin/bash
# Passes when db-0 is a newer pod than its claim (so it was replaced), Robin
# is still listed, and ~/count.txt says 6.
ns="-n bounty-board"
pod=$(kubectl get pod db-0 $ns -o jsonpath='{.metadata.creationTimestamp}' 2>/dev/null)
claim=$(kubectl get pvc data-db-0 $ns -o jsonpath='{.metadata.creationTimestamp}')
python3 - "$pod" "$claim" <<'EOF' || exit 1
import sys
from datetime import datetime
seconds = lambda s: datetime.strptime(s, "%Y-%m-%dT%H:%M:%SZ").timestamp()
sys.exit(0 if seconds(sys.argv[1]) - seconds(sys.argv[2]) > 5 else 1)
EOF
list=$(kubectl exec $ns deploy/web -- wget -qO- -T 3 http://front-door-nginx/api/bounties 2>/dev/null)
printf '%s' "$list" | grep -q '"name":"Nico Robin"' || exit 1
[ "$(tr -d ' \n' < /root/count.txt 2>/dev/null)" = "6" ]
