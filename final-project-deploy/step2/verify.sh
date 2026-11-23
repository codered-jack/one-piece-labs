#!/bin/bash
# Passes when the ConfigMap db-settings in bounty-board names the user bounty
# and the database bounties.
c='kubectl get configmap db-settings -n bounty-board -o jsonpath'
[ "$($c='{.data.POSTGRES_USER}' 2>/dev/null)" = "bounty" ] || exit 1
[ "$($c='{.data.POSTGRES_DB}')" = "bounties" ]
