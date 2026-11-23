Scale the Den Den Mushi to **5** copies, as in the ***Scaling up and down*** lesson. Then check the Service's list:

`kubectl get endpointslices -l kubernetes.io/service-name=den-den`{{exec}}

You didn't touch the Service. It found the two new pods by their label.

Press **Check** when the list has five addresses. If it shows `+ 2 more...`, that's five.

<br>

<details><summary>Tip</summary>

`kubectl scale deployment <name> --replicas=<count>`.

</details>

<details><summary>Solution</summary>

```plain
kubectl scale deployment den-den --replicas=5
kubectl rollout status deployment/den-den
kubectl get endpointslices -l kubernetes.io/service-name=den-den
```{{exec}}

</details>
