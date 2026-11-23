Let an autoscaler pick the number of copies. First, delete the line `replicas: 3` from `~/fleet/den-den-deployment.yaml`, and apply it. Otherwise each `kubectl apply` would reset the count.

Then write `~/fleet/den-den-hpa.yaml`, a HorizontalPodAutoscaler named `den-den` for the `den-den` Deployment. It keeps 1 to 5 copies, aiming for 50% of their CPU request. Apply it, and look at it:

`kubectl get hpa den-den`{{exec}}

`TARGETS` shows `<unknown>` until metrics-server has numbers. Press **Check** when it shows a percentage, like `cpu: 2%/50%`.

<br>

<details><summary>Tip</summary>

`apiVersion: autoscaling/v2`, `kind: HorizontalPodAutoscaler`. Under `spec:`, use `scaleTargetRef:` (the Deployment's `apiVersion`, `kind` and `name`), `minReplicas:`, `maxReplicas:`, and `metrics:` with one `type: Resource` item: `name: cpu`, and a `target:` of `type: Utilization` with `averageUtilization: 50`.

</details>

<details><summary>Solution</summary>

```plain
sed -i '/replicas: 3/d' ~/fleet/den-den-deployment.yaml
kubectl apply -f ~/fleet/den-den-deployment.yaml
cat > ~/fleet/den-den-hpa.yaml <<'EOF'
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: den-den
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: den-den
  minReplicas: 1
  maxReplicas: 5
  metrics:
    - type: Resource
      resource:
        name: cpu
        target:
          type: Utilization
          averageUtilization: 50
EOF
kubectl apply -f ~/fleet/den-den-hpa.yaml
until kubectl get hpa den-den | grep -q '%/50%'; do sleep 5; done
kubectl get hpa den-den
```{{exec}}

</details>
