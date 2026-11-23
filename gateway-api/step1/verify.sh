#!/bin/bash
# Passes when Gateway front-door is of class nginx, has an HTTP listener on
# port 80, and is programmed.
[ "$(kubectl get gateway front-door -o jsonpath='{.spec.gatewayClassName}' 2>/dev/null)" = "nginx" ] || exit 1
kubectl get gateway front-door -o jsonpath='{range .spec.listeners[*]}{.protocol}:{.port}{"\n"}{end}' | grep -qx "HTTP:80" || exit 1
[ "$(kubectl get gateway front-door -o jsonpath='{.status.conditions[?(@.type=="Programmed")].status}')" = "True" ]
