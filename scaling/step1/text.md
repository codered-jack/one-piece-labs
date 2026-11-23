Check the Deployment is running, with three copies:

`kubectl get deployment den-den`{{exec}}

If it doesn't show `3/3` yet, wait a few seconds and run it again. Then scale it to **5** copies, and watch them start:

`kubectl get pods`{{exec}}

Press **Check** when the Deployment shows `5/5`.

<br>

<details><summary>Tip</summary>

`kubectl scale deployment <name> --replicas=<count>` changes how many copies run.

</details>

<details><summary>Solution</summary>

```plain
kubectl scale deployment den-den --replicas=5
kubectl get deployment den-den
```{{exec}}

</details>
