#!/bin/bash
# Passes when the lighthouse container answers on localhost:9090 from the machine.
[ "$(docker inspect -f '{{.State.Running}}' lighthouse 2>/dev/null)" = "true" ] || exit 1
[ "$(curl -s --max-time 5 localhost:9090)" = "The lighthouse is lit." ]
