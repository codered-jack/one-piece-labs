This is the lab for the ***Milestone: Bounty Board on Kubernetes*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` and Docker set up. You'll run the Bounty Board's four parts in the cluster, each as a **Deployment** and a **Service**:

- get the code, and build its three images
- copy the images into the cluster
- start the whole app in a namespace of its own
- open the board, and post a bounty
- lose an API pod, and scale the API up
- lose the database's pod, and see what happens to the data
- remove the app

The cluster has one machine, so all the pods run on it. The lesson runs them on three.

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
