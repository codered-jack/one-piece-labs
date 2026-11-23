#!/bin/bash
# Passes when ~/fleet/ship-settings.yaml exists, and the ConfigMap
# ship-settings has SHIP set to Going Merry.
grep -q "kind: ConfigMap" /root/fleet/ship-settings.yaml 2>/dev/null || exit 1
[ "$(kubectl get configmap ship-settings -o jsonpath='{.data.SHIP}' 2>/dev/null)" = "Going Merry" ]
