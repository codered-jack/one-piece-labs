Write `final/front-door.yaml` with two objects:

- a Gateway named `front-door`, of class `nginx`, with one HTTP listener on port 80
- an HTTPRoute named `bounty-board`, attached to it, with two rules. Calls for the path prefix `/api` go to the `api` Service, on port 8000. Everything else goes to `web`, on port 80.

Apply it into the namespace, and wait for the front door's NGINX:

`kubectl rollout status -n bounty-board deployment/front-door-nginx`{{exec}}

Open the front door in the background, and [open the Bounty Board]({{TRAFFIC_HOST1_9000}}) in a new browser tab:

`kubectl port-forward -n bounty-board service/front-door-nginx 9000:80 --address 0.0.0.0 > /dev/null 2>&1 &`{{exec}}

Post a bounty of 930,000,000 berries for `Nico Robin`, with the form or with `curl`:

`curl -s -X POST -H 'Content-Type: application/json' -d '{"name": "Nico Robin", "bounty": 930000000}' localhost:9000/api/bounties`{{exec}}

Press **Check** when Robin is on the board.

<br>

<details><summary>Tip</summary>

The route's first rule has `matches:`, with a `path:` of `type: PathPrefix` and `value: /api`. The second rule has only `backendRefs:`, so it takes every other path.

</details>

<details><summary>Solution</summary>

```plain
cd ~/one-piece-labs/bounty-board
cat > final/front-door.yaml <<'EOF'
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: front-door
spec:
  gatewayClassName: nginx
  listeners:
    - name: http
      protocol: HTTP
      port: 80
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: bounty-board
spec:
  parentRefs:
    - name: front-door
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /api
      backendRefs:
        - name: api
          port: 8000
    - backendRefs:
        - name: web
          port: 80
EOF
kubectl apply -n bounty-board -f final/front-door.yaml
kubectl wait -n bounty-board --for=condition=Programmed gateway/front-door --timeout=120s
until kubectl get deployment -n bounty-board front-door-nginx >/dev/null 2>&1; do sleep 1; done
kubectl rollout status -n bounty-board deployment/front-door-nginx
kubectl port-forward -n bounty-board service/front-door-nginx 9000:80 --address 0.0.0.0 > /dev/null 2>&1 &
sleep 3
curl -s -X POST -H 'Content-Type: application/json' -d '{"name": "Nico Robin", "bounty": 930000000}' localhost:9000/api/bounties
```{{exec}}

</details>
