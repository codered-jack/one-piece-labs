This is the lab for the ***Probes*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. Already running:

- the `den-den` Deployment, with three copies of the slow Den Den Mushi. Each waits 10 seconds before its web server starts, and has no probes yet.
- the `den-den` Service, on port 80
- the `lookout` pod, to call the Service from

In `~/fleet`, you'll find their files, `den-den-deployment.yaml` and `den-den-service.yaml`. Each Den Den Mushi has two empty files, `ready` and `alive`, that its probes can ask for.

You'll:

- add a **readiness probe**, so calls wait until a copy is ready
- take one copy off the line, without restarting it
- add a **liveness probe**, with a **startup probe** to cover the slow start
- watch the liveness probe restart a stuck copy
- find the event that says why

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
