See the pods that are already here, with their labels:

`kubectl get pods --show-labels`{{exec}}

Now run a pod named `den-den-east`, from `python:3.12-alpine`, running `python3 -m http.server 8000`. Give it two labels: `app=den-den` and `sea=east-blue`.

Press **Check** when it shows up in the list with both labels.

<br>

<details><summary>Tip</summary>

`kubectl run <name> --image=<image> --labels="<key>=<value>,<key>=<value>" -- <command>`. A comma separates the labels.

</details>

<details><summary>Solution</summary>

```plain
kubectl run den-den-east --image=python:3.12-alpine --labels="app=den-den,sea=east-blue" -- python3 -m http.server 8000
kubectl get pods --show-labels
```{{exec}}

</details>
