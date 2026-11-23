# Lab complete

You just:

- closed `node01` to new pods with `kubectl cordon`
- drained it, while the other copies kept answering
- opened it again, and saw that pods don't move back on their own
- drained it under a **PodDisruptionBudget**, one copy at a time
- watched a budget that allows no evictions block a drain

Next up is the ***Gateway API: one front door*** lesson: one address for callers outside the cluster, with each path sent to the right Service.
