This is the lab for the ***ConfigMaps and Secrets*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. Already running:

- the `den-den` Deployment, with two copies of the Den Den Mushi. Its page names the ship in `$SHIP`, but nothing gives it `$SHIP` yet.

In `~/fleet`, you'll find its file, `den-den-deployment.yaml`, and `db.yaml`, a Postgres pod with no password yet.

You'll:

- write the ship's settings in a **ConfigMap**
- hand them to the Den Den Mushi
- change a setting, and get the running app to use it
- keep a password in a **Secret**
- start Postgres with that password

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
