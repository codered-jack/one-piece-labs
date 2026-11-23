Look at the `cook` pod:

`kubectl get pods -l app=cook`{{exec}}

Its `RESTARTS` count goes up: the app starts, then stops. Its status says `Error` or `CrashLoopBackOff`. Ask what it printed:

`kubectl logs deploy/cook`{{exec}}

Then fix `~/fleet/cook.yaml`, and apply it.

Press **Check** when the cook is running, and stays running.

<br>

<details><summary>Tip</summary>

One line of the logs starts with `sh:`. It comes from the shell that runs the command, and names a command it can't find. Compare it with the command in the file.

</details>

<details><summary>Solution</summary>

The command says `pythn3`, a typo for `python3`:

```plain
sed -i 's/pythn3/python3/' ~/fleet/cook.yaml
kubectl apply -f ~/fleet/cook.yaml
kubectl rollout status deployment/cook
```{{exec}}

</details>
