Wait for the three copies:

`kubectl rollout status deployment/den-den`{{exec}}

Write `~/fleet/den-den-service.yaml`: a Service named `den-den` that sends calls to the pods labelled `app: den-den`. Callers use port **80**, and the Den Den Mushi listens on port **8000**. Apply it, then see the Service and its list of pods:

`kubectl get services`{{exec}}

`kubectl get endpointslices -l kubernetes.io/service-name=den-den`{{exec}}

Press **Check** when the list shows three addresses.

<br>

<details><summary>Tip</summary>

A Service starts with `apiVersion: v1` and `kind: Service`. Under `spec:` go `selector:`, with the label, and `ports:`, a list with `port:` and `targetPort:`.

</details>

<details><summary>Solution</summary>

```plain
cat > ~/fleet/den-den-service.yaml <<'EOF'
apiVersion: v1
kind: Service
metadata:
  name: den-den
spec:
  selector:
    app: den-den
  ports:
    - port: 80
      targetPort: 8000
EOF
kubectl apply -f ~/fleet/den-den-service.yaml
kubectl get endpointslices -l kubernetes.io/service-name=den-den
```{{exec}}

</details>
