This is the lab for the ***Final project, The Beginning: deploy the Bounty Board*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` and Docker set up. While you read this, it's getting ready:

- installing Gateway API's CRDs, and **NGINX Gateway Fabric**, the gateway controller
- cloning the labs repository into `~/one-piece-labs`
- building the Bounty Board's three images, and copying them into the cluster
- copying the milestone's manifests, `k8s/`, to a new folder, `final/`, for you to change

It takes two or three minutes. Step 3 waits for it.

You'll deploy the Bounty Board the production way:

- its password in a **Secret**, and its shared settings in a **ConfigMap**
- its database as a **StatefulSet**, with a disk
- the API, with its database address built from the two
- a **Gateway** in front, with a route for `/api` and one for the page
- then lose the database's pod, and keep the data

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
