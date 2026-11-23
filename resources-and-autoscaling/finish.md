# Lab complete

You just:

- gave each copy of the Den Den Mushi a **request** and a **limit**
- saw a pod wait in `Pending`, because no node had 20 CPUs free
- saw a pod `OOMKilled` for going over its memory limit
- created a **HorizontalPodAutoscaler**, and watched it add copies under load

Stop the load with `kubectl delete pod load --now`. In about 5 minutes, the autoscaler takes the Den Den Mushi back to one copy.

Next up is the ***Drains and disruption budgets*** lesson: take a node out for repairs, without the app going down.
