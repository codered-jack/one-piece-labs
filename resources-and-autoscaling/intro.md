This is the lab for the ***Resources and autoscaling*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. It has 1 CPU. Already running:

- the `den-den` Deployment, with three copies of the Den Den Mushi, and no requests or limits yet
- the `den-den` Service, on port 80
- **metrics-server**, which measures what pods really use. It's still starting: `kubectl top pods` works within a minute or two.

In `~/fleet`, you'll find their files, and `hungry.yaml`, a pod that takes 100 MiB of memory.

You'll:

- give each copy a **request** and a **limit**
- start a pod that asks for more than the node has
- watch a pod get killed for going over its memory limit
- create a **HorizontalPodAutoscaler**
- make the Den Den Mushi busy, and watch the autoscaler add copies

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
