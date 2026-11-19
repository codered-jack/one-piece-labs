#!/bin/bash
# Background diagnostics. Every check logs a value or FAILED/MISSING instead of
# aborting, so one failure never hides the rest of the report.
set -uo pipefail

SPIKE_DIR=/root/spike
REPORT="$SPIKE_DIR/report.txt"
mkdir -p "$SPIKE_DIR"
: > "$REPORT"

log() { echo "$*" >> "$REPORT"; }
now() { date +%s; }
elapsed() { echo $(( $(now) - $1 )); }

started=$(now)
log "=== SPIKE REPORT: ubuntu ==="
log "uptime_at_setup_start_s: $(cut -d' ' -f1 /proc/uptime)"
log "os: $(. /etc/os-release && echo "$PRETTY_NAME")"
log "cpus: $(nproc)"
log "memory_total_mb: $(free -m | awk '/^Mem:/{print $2}')"
log "memory_available_mb: $(free -m | awk '/^Mem:/{print $7}')"
log "disk_free_root: $(df -h / | awk 'NR==2{print $4}')"

for tool in docker podman python3 curl git jq ss; do
  if command -v "$tool" >/dev/null 2>&1; then
    log "tool_$tool: $("$tool" --version 2>&1 | head -1)"
  else
    log "tool_$tool: MISSING"
  fi
done

if docker compose version >/dev/null 2>&1; then
  log "docker_compose_plugin: $(docker compose version --short)"
else
  log "docker_compose_plugin: MISSING"
fi
log "docker_compose_standalone: $(command -v docker-compose >/dev/null 2>&1 && docker-compose --version | head -1 || echo MISSING)"
log "docker_registry_mirrors: $(docker info --format '{{.RegistryConfig.Mirrors}}' 2>/dev/null || echo unknown)"

# Base images the Bounty Board would use.
for image in postgres:17-alpine redis:7-alpine node:22-alpine nginx:alpine registry:2; do
  t=$(now)
  if docker pull -q "$image" >/dev/null 2>&1; then
    log "pull_${image}: $(elapsed "$t")s"
  else
    log "pull_${image}: FAILED"
  fi
done

if docker compose version >/dev/null 2>&1; then
  mkdir -p "$SPIKE_DIR/compose"
  cat > "$SPIKE_DIR/compose/compose.yaml" <<'YAML'
services:
  db:
    image: postgres:17-alpine
    environment:
      POSTGRES_PASSWORD: spike
    healthcheck:
      test: ["CMD", "pg_isready", "-U", "postgres"]
      interval: 2s
      retries: 30
  cache:
    image: redis:7-alpine
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 2s
      retries: 30
YAML
  t=$(now)
  if docker compose -f "$SPIKE_DIR/compose/compose.yaml" up -d --wait --wait-timeout 120 >/dev/null 2>&1; then
    log "compose_postgres_redis_healthy: $(elapsed "$t")s"
    log "memory_available_with_stack_mb: $(free -m | awk '/^Mem:/{print $7}')"
  else
    log "compose_postgres_redis_healthy: FAILED"
  fi
  docker compose -f "$SPIKE_DIR/compose/compose.yaml" down -v >/dev/null 2>&1
else
  log "compose_postgres_redis_healthy: SKIPPED (no compose plugin)"
fi

log "setup_total_s: $(elapsed "$started")"
log "=== END ==="
touch "$SPIKE_DIR/done"
