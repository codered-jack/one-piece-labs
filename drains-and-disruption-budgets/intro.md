This is the lab for the ***Drains and disruption budgets*** lesson. This machine runs a two-node Kubernetes cluster, with `kubectl` set up. The nodes are `controlplane` and `node01`. Already running:

- the `den-den` Deployment, with four copies of the Den Den Mushi. Each has a readiness probe, and is ready about 10 seconds after it starts.
- the `den-den` Service, on port 80
- the `lookout` pod, pinned to `controlplane`, to call the Service from

In `~/fleet`, you'll find their files: `den-den-deployment.yaml`, `den-den-service.yaml`, and `lookout.yaml`.

You'll:

- close `node01` to new pods
- drain it, keeping all four copies ready
- open it again, and get copies back onto it
- drain it under a **PodDisruptionBudget**
- make the budget so strict that it blocks a drain

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
