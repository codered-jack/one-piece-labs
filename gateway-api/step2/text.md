The door is open, but it has no routes yet. Knock from the lookout, inside the cluster. NGINX answers `404 Not Found`:

`kubectl exec lookout -- wget -qO- -T 2 http://front-door-nginx`{{exec}}

Create an HTTPRoute named `den-den`. It attaches to `front-door`, and sends every call to the `den-den` Service, on port 80. Save it as `~/fleet/den-den-route.yaml`, and apply it. Then look at the route:

`kubectl get httproutes`{{exec}}

Press **Check** when the route is in place.

<br>

<details><summary>Tip</summary>

An HTTPRoute uses `apiVersion: gateway.networking.k8s.io/v1`. `parentRefs:` lists the Gateway, by `name:`. `rules:` holds one rule with `backendRefs:`, listing the Service's `name:` and `port:`. With no `matches:`, the rule takes every path.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/den-den-route.yaml <<'EOF'
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: den-den
spec:
  parentRefs:
    - name: front-door
  rules:
    - backendRefs:
        - name: den-den
          port: 80
EOF
kubectl apply -f ~/fleet/den-den-route.yaml
sleep 3
kubectl get httproutes
```{{exec}}

</details>
