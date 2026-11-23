There's no Python 3.99. Update the Deployment to `python:3.99-alpine` anyway, this time with `kubectl set image`, which changes the cluster without the file.

Watch the update, with a time limit, because it won't finish:

`kubectl rollout status deployment/den-den --timeout=30s`{{exec}}

Then look at the pods:

`kubectl get pods`{{exec}}

Three 3.13 copies are still `Running`. One new pod says `ErrImagePull` or `ImagePullBackOff`. Its events say why:

`kubectl describe pods | grep Failed`{{exec}}

Press **Check** when the new pod has failed, and the three old copies are still ready.

<br>

<details><summary>Tip</summary>

`kubectl set image deployment/<name> <container>=<image>`. The container here is named `den-den`.

</details>

<details><summary>Solution</summary>

```plain
kubectl set image deployment/den-den den-den=python:3.99-alpine
kubectl rollout status deployment/den-den --timeout=30s
kubectl get pods
```{{exec}}

</details>
