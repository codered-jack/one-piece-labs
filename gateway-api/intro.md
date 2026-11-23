This is the lab for the ***Gateway API: one front door*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. While you read this, it's installing:

- Gateway API's CRDs, and **NGINX Gateway Fabric**, the gateway controller. It runs Gateways of class `nginx`.
- the `den-den` app and Service: four Den Den Mushi
- the `wanted` app and Service, with a wanted poster at `/wanted/`
- the `logbook` app and Service, with a logbook page at `/logbook/`
- the `lookout` pod, to call from inside the cluster

In `~/fleet`, you'll find their files, and one route that isn't applied yet: `logbook-route.yaml`.

You'll:

- open a **Gateway** named `front-door`
- route every call to the Den Den Mushi with an **HTTPRoute**
- send `/wanted` to the wanted poster
- knock on the front door from your browser
- find and fix a broken route

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
