This is the lab for the ***Rolling updates and rollbacks*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. The `den-den` Deployment is already running, with three copies on `python:3.12-alpine`. Its file is `~/fleet/den-den-deployment.yaml`. You'll:

- check which Python it runs
- update it to Python 3.13 with a **rolling update**
- ship an image that doesn't exist, and see the old copies keep running
- **roll back**
- read the Deployment's history

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
