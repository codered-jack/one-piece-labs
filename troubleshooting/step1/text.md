Look at all the pods:

`kubectl get pods`{{exec}}

The `navigator` pod isn't running. Ask what happened to it:

`kubectl describe pod -l app=navigator`{{exec}}

Read the `Events` at the end. Then fix `~/fleet/navigator.yaml`, and apply it.

Press **Check** when the navigator is running.

<br>

<details><summary>Tip</summary>

The `Failed to pull image` line ends in `not found`. Look closely at the image's name and tag. `nano ~/fleet/navigator.yaml` opens the file. Press `Ctrl+O` and `Enter` to save, and `Ctrl+X` to quit.

</details>

<details><summary>Solution</summary>

The tag says `alpien`, a typo for `alpine`:

```plain
sed -i 's/python:3.13-alpien/python:3.13-alpine/' ~/fleet/navigator.yaml
kubectl apply -f ~/fleet/navigator.yaml
kubectl rollout status deployment/navigator
```{{exec}}

</details>
