First, wait until the gateway controller is in. This waits for its GatewayClass, `nginx`, to be accepted:

`kubectl wait --for=condition=Accepted gatewayclass/nginx --timeout=300s`{{exec}}

`kubectl get gatewayclass`{{exec}}

Now create a Gateway named `front-door`, of class `nginx`. Give it one listener, named `http`, for HTTP on port 80. Save it as `~/fleet/front-door.yaml`, and apply it.

The controller starts an NGINX pod and a Service for it, both named `front-door-nginx`. Wait for the pod:

`kubectl rollout status deployment/front-door-nginx`{{exec}}

`kubectl get gateway`{{exec}}

Press **Check** when `PROGRAMMED` says `True`.

<br>

<details><summary>Tip</summary>

A Gateway uses `apiVersion: gateway.networking.k8s.io/v1`. Its `spec:` holds `gatewayClassName: nginx`, and `listeners:`, a list. Each listener has a `name:`, a `protocol:`, and a `port:`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/front-door.yaml <<'EOF'
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
EOF
kubectl wait --for=condition=Accepted gatewayclass/nginx --timeout=300s
kubectl apply -f ~/fleet/front-door.yaml
kubectl wait --for=condition=Programmed gateway/front-door --timeout=120s
until kubectl get deployment front-door-nginx >/dev/null 2>&1; do sleep 1; done
kubectl rollout status deployment/front-door-nginx
kubectl get gateway
```{{exec}}

</details>
