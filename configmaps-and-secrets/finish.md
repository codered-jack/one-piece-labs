# Lab complete

You just:

- wrote the ship's settings in a **ConfigMap**
- handed them to the Den Den Mushi as environment variables
- changed a setting, and replaced the pods to pick it up
- kept a password in a **Secret**, and saw that base64 isn't a lock
- started Postgres with the password from the Secret

Next up is the ***Storage and StatefulSets*** lesson: give Postgres a disk, so its data outlives its pod.
