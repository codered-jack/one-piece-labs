Your file still says 4. Bring the copies back by applying it.

Then check:

`kubectl get deployment den-den`{{exec}}

Press **Check** when the Deployment shows `4/4` again.

<br>

<details><summary>Tip</summary>

`kubectl apply -f` makes the cluster match the file, count and all.

</details>

<details><summary>Solution</summary>

```plain
kubectl apply -f ~/fleet/den-den-deployment.yaml
kubectl rollout status deployment/den-den
```{{exec}}

</details>
