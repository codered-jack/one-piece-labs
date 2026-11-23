The Service `lookout-line` was meant to reach the Den Den Mushi too. Call it:

`kubectl exec lookout -- wget -qO- -T 3 http://lookout-line`{{exec}}

It says `Connection refused`. Check its list of pods:

`kubectl get endpointslices -l kubernetes.io/service-name=lookout-line`{{exec}}

The list is empty. Its file is `~/fleet/lookout-line.yaml`. Find what's wrong, fix the file, and apply it.

Press **Check** when the call works.

<br>

<details><summary>Tip</summary>

Compare the Service's selector with the pods' labels: `cat ~/fleet/lookout-line.yaml`, then `kubectl get pods --show-labels`.

</details>

<details><summary>Solution</summary>

The selector says `den-dem`, a typo for `den-den`:

```plain
sed -i 's/app: den-dem/app: den-den/' ~/fleet/lookout-line.yaml
kubectl apply -f ~/fleet/lookout-line.yaml
kubectl exec lookout -- wget -qO- http://lookout-line
```{{exec}}

</details>
