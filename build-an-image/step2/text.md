Try asking `v1` for Zoro's poster:

`docker run wanted:v1 Zoro`{{exec}}

It fails: whatever you type after the image name replaces the whole `CMD`, so Docker tried to run a program called `Zoro`.

Change the Dockerfile and build `wanted:v2`, so that:

- `docker run wanted:v2 Zoro`{{exec}} prints Zoro's poster
- `docker run wanted:v2`{{exec}} still prints Luffy's

Press **Check** when both work.

<br>

<details><summary>Tip</summary>

Split the command in two. `ENTRYPOINT` is the part that always runs: `["python3", "wanted.py"]`. `CMD` becomes just the default argument, `["Luffy"]`, and it's the part a name after the image replaces.

</details>

<details><summary>Solution</summary>

```plain
cd ~/wanted
cat > Dockerfile <<'EOF'
FROM python:3.12-alpine
WORKDIR /app
COPY wanted.py .
ENTRYPOINT ["python3", "wanted.py"]
CMD ["Luffy"]
EOF
docker build -t wanted:v2 .
```{{exec}}

</details>
