The three `den-den` pods are running. But call their Service from the lookout:

`kubectl exec lookout -- wget -qO- -T 3 http://den-den`{{exec}}

The call is refused. Check the Service's list of pods:

`kubectl get endpointslices -l kubernetes.io/service-name=den-den`{{exec}}

It lists all three pods, so the selector is fine. Look at the `PORTS` column, then at `~/fleet/den-den-deployment.yaml`. Fix `~/fleet/den-den-service.yaml`, and apply it.

Press **Check** when the call works.

<br>

<details><summary>Tip</summary>

The Service sends calls to the pods on its `targetPort`. The Den Den Mushi listens on the port in its command, `http.server 8000`.

</details>

<details><summary>Solution</summary>

The `targetPort` says 8080, but the app listens on 8000:

```plain
sed -i 's/targetPort: 8080/targetPort: 8000/' ~/fleet/den-den-service.yaml
kubectl apply -f ~/fleet/den-den-service.yaml
kubectl exec lookout -- wget -qO- http://den-den
```{{exec}}

</details>
