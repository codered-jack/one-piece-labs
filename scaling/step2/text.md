Now scale the Deployment down to **2** copies. Then look at the pods:

`kubectl get pods`{{exec}}

Three say `Terminating` for up to 30 seconds, as they stop. Kubernetes chose which three.

Press **Check** when the Deployment shows `2/2`.

<br>

<details><summary>Tip</summary>

The same command as the last step, with a smaller number.

</details>

<details><summary>Solution</summary>

```plain
kubectl scale deployment den-den --replicas=2
kubectl get pods
```{{exec}}

</details>
