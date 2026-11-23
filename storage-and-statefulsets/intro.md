This is the lab for the ***Storage and StatefulSets*** lesson. This machine is a one-node Kubernetes cluster, with `kubectl` set up. Already there:

- the Secret `db-password`, holding the practice password `not-a-real-secret`
- `~/fleet/db.yaml`, a Postgres pod that takes its password from that Secret. It has no disk yet.

You'll:

- ask for a disk with a **PersistentVolumeClaim**
- give it to Postgres, and replace the pod without losing data
- run Postgres as a **StatefulSet**, with a name and a disk that stay
- delete the StatefulSet, and see its disk stay

Each step ends with a **Check** button that looks at the cluster and tells you whether the task is done. Stuck? Every step has a **Tip**, and a **Solution** if you need it.

Press **Start** when you're ready.
