Make a namespace named `east-blue`, and start a lookout there:

`kubectl create namespace east-blue`{{exec}}

`kubectl run lookout -n east-blue --image=alpine -- sleep 100000`{{exec}}

From there, the short name doesn't work. Try it:

`kubectl exec -n east-blue lookout -- wget -qO- http://den-den`{{exec}}

It says `bad address`, or the pod isn't running yet: wait a few seconds and try again. Now call the Den Den Mushi from this lookout by a name that works, and save the answer to `~/far.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

Add the Service's namespace to its name: `den-den.default`.

</details>

<details><summary>Solution</summary>

```plain
kubectl create namespace east-blue
kubectl run lookout -n east-blue --image=alpine -- sleep 100000
kubectl wait -n east-blue --for=condition=Ready pod/lookout
kubectl exec -n east-blue lookout -- wget -qO- http://den-den.default > ~/far.txt
cat ~/far.txt
```{{exec}}

</details>
