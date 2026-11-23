A teammate wrote a route for the logbook. Apply it, and try the logbook page:

`kubectl apply -f ~/fleet/logbook-route.yaml`{{exec}}

`curl -si localhost:9000/logbook/`{{exec}}

`500 Internal Server Error`. `kubectl apply` was happy, so the mistake isn't in the file's shape. Read the route's status, under `Conditions`:

`kubectl describe httproute logbook`{{exec}}

Compare it with the Services that exist:

`kubectl get services`{{exec}}

Fix the mistake in `~/fleet/logbook-route.yaml`, apply it again, and call the page. Press **Check** when the logbook answers.

<br>

<details><summary>Tip</summary>

Look at the `ResolvedRefs` condition. Its message names the Service the route asks for. The real Service is `logbook`.

</details>

<details><summary>Solution</summary>

```plain
sed -i 's/name: log-book/name: logbook/' ~/fleet/logbook-route.yaml
kubectl apply -f ~/fleet/logbook-route.yaml
sleep 3
curl -s localhost:9000/logbook/
```{{exec}}

</details>
