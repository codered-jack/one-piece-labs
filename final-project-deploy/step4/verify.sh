#!/bin/bash
# Passes when api, web and cache are fully ready, the API takes DB_PASSWORD
# from the Secret and holds no password of its own, no file in final/ holds
# the password, and the API reaches both the database and the cache.
ns="-n bounty-board"
for d in api web cache; do
  want=$(kubectl get deployment "$d" $ns -o jsonpath='{.spec.replicas}' 2>/dev/null)
  [ -n "$want" ] || exit 1
  [ "$(kubectl get deployment "$d" $ns -o jsonpath='{.status.readyReplicas}')" = "$want" ] || exit 1
done
[ "$(kubectl get deployment api $ns -o jsonpath='{.spec.template.spec.containers[0].env[?(@.name=="DB_PASSWORD")].valueFrom.secretKeyRef.name}')" = "db-password" ] || exit 1
kubectl get deployment api $ns -o yaml | grep -q "not-a-real-secret" && exit 1
grep -rq "not-a-real-secret" /root/one-piece-labs/bounty-board/final/ && exit 1
health=$(kubectl exec $ns deploy/web -- wget -qO- http://api:8000/api/health 2>/dev/null)
printf '%s' "$health" | grep -q '"database":"up"' || exit 1
printf '%s' "$health" | grep -q '"cache":"up"'
