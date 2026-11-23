Wait for the three copies:

`kubectl rollout status deployment/den-den`{{exec}}

Then ask one of them which Python it runs, and save the answer to `~/version.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`kubectl exec deploy/den-den -- <command>` runs a command in any one pod of the Deployment. `python3 --version` prints the version.

</details>

<details><summary>Solution</summary>

```plain
kubectl exec deploy/den-den -- python3 --version > ~/version.txt
cat ~/version.txt
```{{exec}}

</details>
