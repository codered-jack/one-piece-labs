Kubernetes won't undo the update by itself. Go back to the last working version with `kubectl rollout undo`.

The undo prints a warning about your file. Your file still says 3.13, which is the version you're going back to, so it's fine here.

Then check:

`kubectl get pods`{{exec}}

The broken pod goes, and the three 3.13 copies keep running.

Press **Check** when the Deployment is back on `python:3.13-alpine`.

<br>

<details><summary>Tip</summary>

`kubectl rollout undo deployment/<name>` goes back one revision.

</details>

<details><summary>Solution</summary>

```plain
kubectl rollout undo deployment/den-den
kubectl rollout status deployment/den-den
kubectl get pods
```{{exec}}

</details>
