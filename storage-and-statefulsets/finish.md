# Lab complete

You just:

- asked for a disk with a **PersistentVolumeClaim**, and saw it made once a pod needed it
- gave the disk to Postgres, and replaced its pod without losing Robin
- ran Postgres as a **StatefulSet**, behind a headless Service
- replaced `db-0`, and saw it come back with the same name and the same disk
- deleted the StatefulSet, and saw its disk stay

Next up is the ***Probes*** lesson: tell Kubernetes when an app is really ready, and when it's stuck.
