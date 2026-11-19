#!/bin/bash
# shellcheck source=/dev/null
source /root/spike/lib.sh
wait_for_base_checks

log "--- traefik ---"
if ensure_helm; then
  memory_before=$(node_memory_used_mi)
  t=$(now)
  if helm repo add traefik https://traefik.github.io/charts >/dev/null 2>&1 \
    && helm repo update >/dev/null 2>&1 \
    && helm install traefik traefik/traefik -n traefik --create-namespace \
      --set providers.kubernetesGateway.enabled=true \
      --set gateway.enabled=false \
      --wait --timeout 5m >/dev/null 2>&1; then
    log "traefik_chart_version: $(helm list -n traefik -o json | jq -r '.[0].chart')"
    log "traefik_controller_ready: $(elapsed "$t")s"
    # Traefik's Gateway listeners must use one of its entrypoint ports; 8000 is "web".
    measure_gateway traefik traefik 8000 "$memory_before"
  else
    log "traefik_controller_ready: FAILED"
  fi
fi
echo "STEP DONE: press Next"
