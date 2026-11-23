So far, you've knocked from inside the cluster. Visitors come from outside. In a cloud, the `front-door-nginx` Service would get a public address. Here it stays `<pending>`:

`kubectl get service front-door-nginx`{{exec}}

Stand in for the cloud with `port-forward`. This runs it in the background, on port 9000. `--address 0.0.0.0` lets the link below reach it:

`kubectl port-forward service/front-door-nginx 9000:80 --address 0.0.0.0 > /dev/null 2>&1 &`{{exec}}

[Open the wanted poster]({{TRAFFIC_HOST1_9000}}/wanted/) in a new browser tab. Then try [the front door's root]({{TRAFFIC_HOST1_9000}}): a Den Den Mushi answers.

Save the wanted poster's text, from `localhost:9000/wanted/`, to `~/poster.txt`. Press **Check** when it's saved.

<br>

<details><summary>Tip</summary>

`curl -s localhost:9000/wanted/` prints the poster. `> ~/poster.txt` saves it to the file.

</details>

<details><summary>Solution</summary>

```plain
kubectl port-forward service/front-door-nginx 9000:80 --address 0.0.0.0 > /dev/null 2>&1 &
sleep 3
curl -s localhost:9000/wanted/ > ~/poster.txt
cat ~/poster.txt
```{{exec}}

</details>
