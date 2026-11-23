# Lab complete

You just deployed the Bounty Board the production way:

- its password in a **Secret**, in no file
- its shared settings in a **ConfigMap**
- its database as a **StatefulSet**, on a disk that outlived the pod
- the API's `DATABASE_URL`, built by Kubernetes from both
- a **Gateway** in front, with one route and two rules

Next up is the ***Final project, The Conclusion: make it production-ready*** lesson: probes, limits, autoscaling, a disruption budget, and an update that nobody notices.
