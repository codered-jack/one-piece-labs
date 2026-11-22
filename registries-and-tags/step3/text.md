First, put `latest` on version 1.0 too:

`docker tag wanted:v2 localhost:5000/wanted:latest && docker push localhost:5000/wanted:latest`{{exec}}

`docker run localhost:5000/wanted:latest`{{exec}} prints the 1,000-berry poster.

Now ship version 1.1, with a default bounty of `30,000,000`:

1. Add `ENV BOUNTY=30,000,000` to the Dockerfile, and build it as `wanted:v3`.
2. Push it as `localhost:5000/wanted:1.1`.
3. Move `latest` to it, and push `latest` again.

Run `latest` once more:

`docker run localhost:5000/wanted:latest`{{exec}}

Same command, new poster: the tag moved. Press **Check** when `1.1` and `latest` both give the 30,000,000 bounty, and `1.0` still gives 1,000.

<br>

<details><summary>Tip</summary>

`ENV` goes anywhere after `FROM`. Tag the new image twice, once as `localhost:5000/wanted:1.1` and once as `localhost:5000/wanted:latest`, and push each name.

</details>

<details><summary>Solution</summary>

```plain
cd ~/wanted
cat > Dockerfile <<'EOF'
FROM python:3.12-alpine
WORKDIR /app
ENV BOUNTY=30,000,000
COPY wanted.py .
ENTRYPOINT ["python3", "wanted.py"]
CMD ["Luffy"]
EOF
docker build -t wanted:v3 .
docker tag wanted:v3 localhost:5000/wanted:1.1
docker tag wanted:v3 localhost:5000/wanted:latest
docker push localhost:5000/wanted:1.1
docker push localhost:5000/wanted:latest
```{{exec}}

</details>
