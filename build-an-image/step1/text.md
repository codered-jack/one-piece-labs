Go to the app's folder and look at the app:

`cd ~/wanted && cat wanted.py`{{exec}}

In `~/wanted`, write a `Dockerfile` that:

- starts from `python:3.12-alpine`
- copies `wanted.py` into the image
- runs `wanted.py` for `Luffy` by default

Build it as `wanted:v1`, then run it:

`docker run wanted:v1`{{exec}}

It should print `WANTED: Luffy - bounty 1,000 berries`. Press **Check** when it does.

<br>

<details><summary>Tip</summary>

You need four instructions: `FROM`, `WORKDIR`, `COPY` and `CMD`. Write `CMD` as a list: `["python3", "wanted.py", "Luffy"]`.

`docker build -t wanted:v1 .` builds from the Dockerfile in the current folder. The `.` is the build context: the folder Docker copies files from.

</details>

<details><summary>Solution</summary>

This writes the Dockerfile without an editor, then builds it:

```plain
cd ~/wanted
cat > Dockerfile <<'EOF'
FROM python:3.12-alpine
WORKDIR /app
COPY wanted.py .
CMD ["python3", "wanted.py", "Luffy"]
EOF
docker build -t wanted:v1 .
```{{exec}}

</details>
