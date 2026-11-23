#!/bin/bash
# Passes when ~/east-blue.txt lists exactly the pods labelled sea=east-blue,
# one per line, with or without the pod/ prefix that -o name adds.
[ -f /root/east-blue.txt ] || exit 1
want=$(kubectl get pods -l sea=east-blue -o name | sed 's#^pod/##' | sort)
[ -n "$want" ] || exit 1
got=$(sed 's#^pod/##; s/[[:space:]]//g; /^$/d' /root/east-blue.txt | sort)
[ "$got" = "$want" ]
