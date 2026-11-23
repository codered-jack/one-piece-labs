This is the lab for the ***Troubleshooting*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. Four things in it are broken, each in its own way. Their files are in `~/fleet`. You'll find out why each one doesn't work, and fix it, with four questions:

- `kubectl get pods`: what state is it in?
- `kubectl describe pod`: what happened to it?
- `kubectl logs`: what did the app print?
- `kubectl get events`: what happened in the whole namespace?

Fix each problem in its file, then apply the file, so the fix lasts.

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
