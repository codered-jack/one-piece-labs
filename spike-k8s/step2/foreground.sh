#!/bin/bash
# shellcheck source=/dev/null
source /root/spike/lib.sh
wait_for_base_checks

log "--- nginx-gateway-fabric ---"
tag=$(latest_tag nginx/nginx-gateway-fabric)
log "nginx_gateway_fabric_tag: $tag"
memory_before=$(node_memory_used_mi)
t=$(now)
if kubectl apply --server-side --force-conflicts \
  -f https://github.com/kubernetes-sigs/gateway-api/releases/latest/download/standard-install.yaml >/dev/null 2>&1 \
  && kubectl apply --server-side --force-conflicts \
    -f "https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/${tag}/deploy/crds.yaml" >/dev/null 2>&1 \
  && kubectl apply -f "https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/${tag}/deploy/default/deploy.yaml" >/dev/null 2>&1 \
  && kubectl -n nginx-gateway wait --for=condition=Available deployment --all --timeout=300s >/dev/null 2>&1; then
  log "nginx_controller_ready: $(elapsed "$t")s"
  measure_gateway nginx nginx 80 "$memory_before"
else
  log "nginx_controller_ready: FAILED"
fi
echo "STEP DONE: press Next"
