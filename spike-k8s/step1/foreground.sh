#!/bin/bash
# shellcheck source=/dev/null
source /root/spike/lib.sh
wait_for_base_checks

log "--- envoy-gateway ---"
log "envoy_gateway_tag: $(latest_tag envoyproxy/gateway)"
memory_before=$(node_memory_used_mi)
t=$(now)
if kubectl apply --server-side --force-conflicts \
  -f https://github.com/envoyproxy/gateway/releases/latest/download/install.yaml >/dev/null 2>&1 \
  && kubectl -n envoy-gateway-system wait --for=condition=Available deployment --all --timeout=300s >/dev/null 2>&1; then
  log "envoy_controller_ready: $(elapsed "$t")s"
  kubectl apply -f - >/dev/null <<'YAML'
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: eg
spec:
  controllerName: gateway.envoyproxy.io/gatewayclass-controller
YAML
  measure_gateway envoy eg 80 "$memory_before"
else
  log "envoy_controller_ready: FAILED"
fi
echo "STEP DONE: press Next"
