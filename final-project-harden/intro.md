This is the lab for the ***Final project, part 2: make it production-ready*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` and Docker set up. While you read this, it's rebuilding the end of part 1:

- installing Gateway API's CRDs, **NGINX Gateway Fabric**, and **metrics-server**
- cloning the labs repository into `~/one-piece-labs`, and building the Bounty Board's images
- writing `final/` as part 1 left it, and starting the board in the `bounty-board` namespace, with Nico Robin on it
- starting `lookout`, a pod to call the board from inside the cluster

It takes three or four minutes. Step 1 waits for it.

You'll make the board ready for a busy day and for maintenance:

- a readiness probe on every part, and a liveness probe on the API
- requests and limits on every part
- an **HPA** that picks the number of API copies
- disruption budgets for the API and the page
- a `preStop` pause, then an update that no caller notices
- a load test, to watch the HPA add copies

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
