#!/bin/bash
# Installs the Gateway API CRDs and NGINX Gateway Fabric, clones the labs
# repository, builds the Bounty Board's three images and copies them into
# containerd, then copies k8s/ to final/ for the learner to change. Touches
# /root/.setup-done when all of it has finished.
until kubectl get nodes >/dev/null 2>&1; do sleep 1; done
kubectl apply --server-side -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.7.0/standard-install.yaml
kubectl apply --server-side -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.9.0/deploy/crds.yaml
kubectl apply -f https://raw.githubusercontent.com/nginx/nginx-gateway-fabric/v2.9.0/deploy/default/deploy.yaml
cd /root
git clone https://github.com/codered-jack/one-piece-labs
cd /root/one-piece-labs/bounty-board
docker build -t bounty-board-web:1.0 web
docker build -t bounty-board-api:1.0 api
docker build -t bounty-board-db:1.0 db
docker save bounty-board-web:1.0 bounty-board-api:1.0 bounty-board-db:1.0 | ctr -n k8s.io images import -
cp -r k8s final
kubectl rollout status deployment/nginx-gateway -n nginx-gateway --timeout=300s
touch /root/.setup-done
