# Lab complete

You just:

- updated a Deployment with a **rolling update**: a new ReplicaSet grew while the old one shrank
- shipped a broken image, and saw the old copies keep running
- **rolled back** with `kubectl rollout undo`
- read the history, and saw that an undo makes a new revision

Next up is the ***Services*** lesson: one address for all the copies, and calls that keep working through an update.
