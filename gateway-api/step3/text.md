Every path goes to the Den Den Mushi now, `/wanted/` too. Its web server has no such page, so it answers `404 File not found`:

`kubectl exec lookout -- wget -qO- -T 2 http://front-door-nginx/wanted/`{{exec}}

Create a second HTTPRoute, named `wanted`. It attaches to `front-door`, and sends any path that starts with `/wanted` to the `wanted` Service, on port 80. Save it as `~/fleet/wanted-route.yaml`, and apply it. Then knock again:

`kubectl exec lookout -- wget -qO- -T 2 http://front-door-nginx/wanted/`{{exec}}

Press **Check** when the wanted poster answers.

<br>

<details><summary>Tip</summary>

Add `matches:` to the rule, above `backendRefs:`. It's a list. Each item holds a `path:` with `type: PathPrefix` and `value: /wanted`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/wanted-route.yaml <<'EOF'
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: wanted
spec:
  parentRefs:
    - name: front-door
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /wanted
      backendRefs:
        - name: wanted
          port: 80
EOF
kubectl apply -f ~/fleet/wanted-route.yaml
sleep 3
kubectl get httproutes
```{{exec}}

</details>
