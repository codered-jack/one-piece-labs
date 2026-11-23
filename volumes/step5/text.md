Time to clear the dock. Remove the `deck` and `visitor` containers, and the `logbook` volume.

Volumes outlive containers on purpose, so `docker rm` never deletes one. You delete a volume yourself, once no container uses it. Your folder is different: removing a container never touches it, so `~/wanted/crew.txt` stays.

`docker volume ls`{{exec}}

`cat ~/wanted/crew.txt`{{exec}}

Press **Check** when the containers and the volume are gone.

<br>

<details><summary>Tip</summary>

`docker rm -f` stops and removes running containers in one go. `docker volume rm` deletes a volume. If it says `volume is in use`, a container still uses it: remove that container first.

</details>

<details><summary>Solution</summary>

```plain
docker rm -f deck visitor
docker volume rm logbook
```{{exec}}

</details>
