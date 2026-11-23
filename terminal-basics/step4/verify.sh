#!/bin/bash
# Passes when the port-9090 server answers on the machine's own IPv4 address,
# which a server bound to 127.0.0.1 never does.
address=$(hostname -I | tr ' ' '\n' | grep -m 1 -E '^[0-9]+(\.[0-9]+){3}$')
[ -n "$address" ] && curl -fs -o /dev/null --max-time 3 "http://$address:9090"
