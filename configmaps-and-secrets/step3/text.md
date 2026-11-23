The crew has a new ship. In `~/fleet/ship-settings.yaml`, change `SHIP` to `Thousand Sunny`, and apply it. Wait a minute, then look at the page:

`kubectl exec deploy/den-den -- cat index.html`{{exec}}

Still the Going Merry. A container gets its environment variables once, when it starts. Get the running Den Den Mushi to name the Thousand Sunny.

Press **Check** when every copy does.

<br>

<details><summary>Tip</summary>

The pods have to be replaced. `kubectl rollout restart deployment/<name>` replaces them, one by one, as a rolling update.

</details>

<details><summary>Solution</summary>

```plain
sed -i 's/SHIP: Going Merry/SHIP: Thousand Sunny/' ~/fleet/ship-settings.yaml
kubectl apply -f ~/fleet/ship-settings.yaml
kubectl rollout restart deployment/den-den
kubectl rollout status deployment/den-den
kubectl exec deploy/den-den -- cat index.html
```{{exec}}

</details>
