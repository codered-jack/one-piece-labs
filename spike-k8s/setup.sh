#!/bin/bash
# Background diagnostics. Every check logs a value or FAILED/MISSING instead of
# aborting, so one failure never hides the rest of the report.
set -uo pipefail

SPIKE_DIR=/root/spike
mkdir -p "$SPIKE_DIR"
: > "$SPIKE_DIR/report.txt"

# Shared helpers for this script and the step scripts.
cat > "$SPIKE_DIR/lib.sh" <<'LIB'
SPIKE_DIR=/root/spike
REPORT="$SPIKE_DIR/report.txt"

log() { echo "$*" | tee -a "$REPORT"; }
now() { date +%s; }
elapsed() { echo $(( $(now) - $1 )); }

# Resolves a GitHub repo's latest release tag via the web redirect, which
# avoids the unauthenticated API rate limit on shared lab IPs.
latest_tag() {
  curl -fsSLI -o /dev/null -w '%{url_effective}' "https://github.com/$1/releases/latest" | sed 's#.*/tag/##'
}

node_memory_used_mi() {
  kubectl top node --no-headers 2>/dev/null | awk '{gsub("Mi","",$4); print $4}'
}

ensure_helm() {
  if command -v helm >/dev/null 2>&1; then
    log "helm_preinstalled: $(helm version --short 2>/dev/null)"
    return 0
  fi
  local t
  t=$(now)
  if curl -fsSL https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash >/dev/null 2>&1; then
    log "helm_installed_in: $(elapsed "$t")s"
  else
    log "helm_install: FAILED"
    return 1
  fi
}

# Applies a test Gateway for the class, then records how long it takes to be
# Accepted and Programmed, and how much node memory the controller added.
measure_gateway() {
  local name=$1 class=$2 port=$3 memory_before=$4 t
  kubectl apply -f - >/dev/null <<YAML
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: spike-$name
  namespace: default
spec:
  gatewayClassName: $class
  listeners:
    - name: http
      protocol: HTTP
      port: $port
YAML
  t=$(now)
  if kubectl wait --for=condition=Accepted "gateway/spike-$name" --timeout=120s >/dev/null 2>&1; then
    log "${name}_gateway_accepted: $(elapsed "$t")s"
  else
    log "${name}_gateway_accepted: FAILED"
  fi
  if kubectl wait --for=condition=Programmed "gateway/spike-$name" --timeout=120s >/dev/null 2>&1; then
    log "${name}_gateway_programmed: $(elapsed "$t")s"
  else
    log "${name}_gateway_programmed: NO (reason: $(kubectl get "gateway/spike-$name" -o jsonpath='{.status.conditions[?(@.type=="Programmed")].reason}' 2>/dev/null))"
  fi
  sleep 30
  local memory_after
  memory_after=$(node_memory_used_mi)
  log "${name}_node_memory_added_mi: $(( ${memory_after:-0} - ${memory_before:-0} ))"
  log "${name}_node_memory_used_after_mi: ${memory_after:-unknown}"
  log "${name}_memory_available_after_mb: $(free -m | awk '/^Mem:/{print $7}')"
  kubectl delete "gateway/spike-$name" --wait=false >/dev/null 2>&1
}

wait_for_base_checks() {
  until [ -f "$SPIKE_DIR/done" ]; do sleep 2; done
}
LIB

# shellcheck source=/dev/null
source "$SPIKE_DIR/lib.sh"

started=$(now)
log "=== SPIKE REPORT: kubernetes ==="
log "uptime_at_setup_start_s: $(cut -d' ' -f1 /proc/uptime)"
log "kubernetes_server: $(kubectl version -o json 2>/dev/null | jq -r '.serverVersion.gitVersion' 2>/dev/null || echo unknown)"
log "nodes: $(kubectl get nodes --no-headers 2>/dev/null | awk '{print $1"("$2")"}' | tr '\n' ' ')"
log "cpus: $(nproc)"
log "memory_total_mb: $(free -m | awk '/^Mem:/{print $2}')"
log "memory_available_mb: $(free -m | awk '/^Mem:/{print $7}')"
log "container_runtime: $(kubectl get nodes -o jsonpath='{.items[0].status.nodeInfo.containerRuntimeVersion}' 2>/dev/null)"
log "kube_system_pods: $(kubectl get pods -n kube-system --no-headers 2>/dev/null | awk '{print $1}' | sed 's/-[a-z0-9]\{5,10\}\(-[a-z0-9]\{5\}\)\?$//' | sort -u | tr '\n' ' ')"
log "namespaces: $(kubectl get ns --no-headers 2>/dev/null | awk '{print $1}' | tr '\n' ' ')"

for tool in docker nerdctl podman buildah crictl ctr helm jq; do
  if command -v "$tool" >/dev/null 2>&1; then
    log "tool_$tool: $("$tool" --version 2>&1 | head -1)"
  else
    log "tool_$tool: MISSING"
  fi
done

log "storage_classes: $(kubectl get storageclass --no-headers 2>/dev/null | awk '{print $1" "$2}' | tr '\n' ';' || echo none)"
log "ingress_classes: $(kubectl get ingressclass --no-headers 2>/dev/null | awk '{print $1}' | tr '\n' ' ')"
log "gateway_api_crds: $(kubectl get crd gateways.gateway.networking.k8s.io >/dev/null 2>&1 && echo present || echo absent)"

# A claim with no storageClassName binds only if a default class exists.
kubectl apply -f - >/dev/null 2>&1 <<'YAML'
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: spike-pvc
spec:
  accessModes: [ReadWriteOnce]
  resources:
    requests:
      storage: 100Mi
---
apiVersion: v1
kind: Pod
metadata:
  name: spike-pvc-pod
spec:
  containers:
    - name: writer
      image: busybox:1.36
      command: ["sh", "-c", "echo ok > /data/ok && sleep 3600"]
      volumeMounts:
        - name: data
          mountPath: /data
  volumes:
    - name: data
      persistentVolumeClaim:
        claimName: spike-pvc
YAML
t=$(now)
if kubectl wait --for=jsonpath='{.status.phase}'=Bound pvc/spike-pvc --timeout=120s >/dev/null 2>&1; then
  log "pvc_without_class_bound: $(elapsed "$t")s"
else
  log "pvc_without_class_bound: FAILED (phase: $(kubectl get pvc spike-pvc -o jsonpath='{.status.phase}' 2>/dev/null))"
fi
kubectl delete pod/spike-pvc-pod pvc/spike-pvc --wait=false >/dev/null 2>&1

if kubectl top nodes >/dev/null 2>&1; then
  log "metrics_server: preinstalled"
else
  t=$(now)
  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml >/dev/null 2>&1
  # kubeadm kubelets serve self-signed certificates.
  kubectl -n kube-system patch deployment metrics-server --type=json \
    -p='[{"op":"add","path":"/spec/template/spec/containers/0/args/-","value":"--kubelet-insecure-tls"}]' >/dev/null 2>&1
  deadline=$(( $(now) + 240 ))
  until kubectl top nodes >/dev/null 2>&1 || [ "$(now)" -ge "$deadline" ]; do sleep 3; done
  if kubectl top nodes >/dev/null 2>&1; then
    log "metrics_server_install_to_top_nodes: $(elapsed "$t")s"
  else
    log "metrics_server_install_to_top_nodes: FAILED within 240s"
  fi
fi
log "node_memory_used_baseline_mi: $(node_memory_used_mi)"

log "setup_total_s: $(elapsed "$started")"
log "=== BASE CHECKS DONE ==="
touch "$SPIKE_DIR/done"
