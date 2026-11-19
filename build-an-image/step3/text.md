`wanted.py` reads the bounty from the `BOUNTY` environment variable, and uses `1,000` when it isn't set.

Build `wanted:v3`, which works like `v2` but has a **default bounty of `30,000,000`**, without editing `wanted.py`:

`docker run wanted:v3`{{exec}}

It should print `WANTED: Luffy - bounty 30,000,000 berries`. A bounty given at run time still wins:

`docker run -e BOUNTY=3,000,000,000 wanted:v3 Luffy`{{exec}}

Press **Check** when the default is `30,000,000`.

<br>

<details><summary>Tip</summary>

`ENV NAME=value` in a Dockerfile bakes an environment variable into the image. Every container started from it gets that value, unless `docker run -e` sets another.

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
```{{exec}}

</details>
