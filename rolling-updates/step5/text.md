List the Deployment's revisions:

`kubectl rollout history deployment/den-den`{{exec}}

Revision 1 is 3.12, and 3 is the broken 3.99. Revision 2, the first 3.13, is gone: the undo ran its template again, as a new revision. The running revision is the last one in the list.

Save its number to `~/revision.txt`.

Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`echo <number> > ~/revision.txt` saves a number.

</details>

<details><summary>Solution</summary>

If you followed the steps in order, it's 4:

```plain
kubectl rollout history deployment/den-den
echo 4 > ~/revision.txt
```{{exec}}

</details>
