The control plane's parts run as pods in the `kube-system` namespace. List them:

`kubectl get pods -n kube-system`{{exec}}

One of them is the **scheduler**, the part that picks a node for each new pod. Save its name to `~/scheduler.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

The scheduler's name starts with `kube-scheduler-`, followed by the name of the node it runs on.

</details>

<details><summary>Solution</summary>

The name is `kube-scheduler-`, then the node's name. `$(cat ~/node.txt)` puts in the name you saved in the last step:

```plain
echo "kube-scheduler-$(cat ~/node.txt)" > ~/scheduler.txt
cat ~/scheduler.txt
```{{exec}}

</details>
