This is the lab for the ***Services*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. Already running:

- the `den-den` Deployment, with three copies of the Den Den Mushi
- a pod named `lookout`, to make calls from
- a Service named `lookout-line`, which has something wrong with it

You'll:

- give the Den Den Mushi one name and address with a **Service**
- call it, and see every copy answer
- watch the Service's list grow as you scale
- call it from another namespace
- fix the broken Service

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
