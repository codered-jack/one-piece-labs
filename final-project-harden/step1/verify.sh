#!/bin/bash
# Passes when setup has finished, each part has its readiness probe, the API
# has a TCP liveness probe on 8000, and every part has rolled out and is ready.
[ -f /root/.setup-done ] || exit 1
ns="-n bounty-board"
c='{.spec.template.spec.containers[0]'
[ "$(kubectl get deployment api $ns -o jsonpath="$c.readinessProbe.httpGet.path}")" = "/api/health" ] || exit 1
[ "$(kubectl get deployment api $ns -o jsonpath="$c.readinessProbe.httpGet.port}")" = "8000" ] || exit 1
[ "$(kubectl get deployment api $ns -o jsonpath="$c.livenessProbe.tcpSocket.port}")" = "8000" ] || exit 1
[ "$(kubectl get deployment web $ns -o jsonpath="$c.readinessProbe.httpGet.path}")" = "/" ] || exit 1
kubectl get deployment cache $ns -o jsonpath="$c.readinessProbe.exec.command}" | grep -q "redis-cli" || exit 1
kubectl get statefulset db $ns -o jsonpath="$c.readinessProbe.exec.command}" | grep -q "pg_isready" || exit 1
for d in api web cache; do
  want=$(kubectl get deployment "$d" $ns -o jsonpath='{.spec.replicas}')
  for f in replicas readyReplicas updatedReplicas; do
    [ "$(kubectl get deployment "$d" $ns -o jsonpath="{.status.$f}")" = "$want" ] || exit 1
  done
done
[ "$(kubectl get statefulset db $ns -o jsonpath='{.status.readyReplicas}')" = "1" ] || exit 1
[ "$(kubectl get statefulset db $ns -o jsonpath='{.status.currentRevision}')" = "$(kubectl get statefulset db $ns -o jsonpath='{.status.updateRevision}')" ]
