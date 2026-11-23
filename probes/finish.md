# Lab complete

You just:

- added a **readiness probe**, so the Service sends calls only to ready copies
- took one copy off the line, with no restart
- added a **liveness probe**, and a **startup probe** so the slow start doesn't trip it
- watched the liveness probe restart a stuck copy
- read the event that said why

Next up is the ***Resources and autoscaling*** lesson: tell Kubernetes how much CPU and memory each pod needs, and add pods when they're busy.
