#!/bin/bash
# Passes when setup has installed Compose and the Bounty Board's compose.yaml
# is in ~/one-piece-labs.
[ -f /root/.setup-done ] || exit 1
[ -f /root/one-piece-labs/bounty-board/compose.yaml ]
