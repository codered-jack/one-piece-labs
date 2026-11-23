# Lab complete

You just ran the Bounty Board on Kubernetes:

- built its three images, and copied them into the cluster
- started all four parts in one namespace, each a **Deployment** and a **Service**
- posted a bounty through the board
- lost an API pod without anyone noticing, and scaled the API up
- lost the database's pod, and its data with it
- removed the whole app with its namespace

The lost data is the next thing to fix. The Production part keeps it, in the ***Storage and StatefulSets*** lesson.
