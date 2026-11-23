# Lab complete

You just fixed four kinds of trouble:

- an image that can't be downloaded: `ImagePullBackOff`, and a `not found` in the events
- an app that keeps stopping: `RESTARTS` going up, and the reason in its logs
- a pod no node will take: `Pending`, and a `FailedScheduling` event
- a Service on the wrong port: `Connection refused`, with a full EndpointSlice

And you deleted everything a folder of files made, with `kubectl delete -f`.

Next up is the ***Milestone: Bounty Board on Kubernetes*** lesson: move the whole Bounty Board into the cluster.
