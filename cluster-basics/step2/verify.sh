#!/bin/bash
# Passes when ~/scheduler.txt holds the name of the scheduler's pod. kubeadm
# labels it component=kube-scheduler.
scheduler=$(kubectl get pods -n kube-system -l component=kube-scheduler -o jsonpath='{.items[0].metadata.name}')
[ -n "$scheduler" ] || exit 1
[ "$(tr -d '[:space:]' < /root/scheduler.txt 2>/dev/null)" = "$scheduler" ]
