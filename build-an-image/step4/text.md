`~/wanted` holds more than the app. List everything, hidden files included:

`ls -a ~/wanted`{{exec}}

There's a `.env` file. In a real project it would hold passwords; this one is fake.

1. In the Dockerfile, change `COPY wanted.py .` to `COPY . .`, so the whole folder goes in.
2. Add a `.dockerignore` file next to the Dockerfile that keeps `.env` out.
3. Build `wanted:v4`, then list what landed in `/app`:

`docker run --entrypoint ls wanted:v4 -a /app`{{exec}}

Press **Check** when `/app` has `wanted.py` but no `.env`. Keep the `.env` file itself: the point is to leave it out of the image, not to delete it.

<br>

<details><summary>Tip</summary>

`.dockerignore` lists what Docker leaves out of the build context, one pattern per line. A file left out of the context can't be copied, so `COPY . .` never sees it.

Curious? Build once with `COPY . .` and no `.dockerignore`, and run the `ls` above: `.env` is right there in the image.

</details>

<details><summary>Solution</summary>

```plain
cd ~/wanted
echo .env > .dockerignore
cat > Dockerfile <<'EOF'
FROM python:3.12-alpine
WORKDIR /app
ENV BOUNTY=30,000,000
COPY . .
ENTRYPOINT ["python3", "wanted.py"]
CMD ["Luffy"]
EOF
docker build -t wanted:v4 .
```{{exec}}

</details>
