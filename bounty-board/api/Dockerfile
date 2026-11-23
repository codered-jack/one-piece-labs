# The api service's image: the Python app, with the libraries it needs.

# Start from Python, on a small Alpine Linux.
FROM python:3.12-alpine
# Work in /app: the next steps copy files to it, and the app runs from it.
WORKDIR /app
# Copy the list of libraries first, and install them. This layer is rebuilt
# only when requirements.txt changes, not on every code change.
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
# Then copy the app's code.
COPY app.py bounties.py ./
# Run as the user nobody, not root: if the app is ever broken into, the
# intruder can change very little.
USER nobody
# Note that the app listens on port 8000. EXPOSE documents it; publishing the
# port is up to whoever runs the container.
EXPOSE 8000
# Start the app with gunicorn, a server for Python web apps:
#   --bind 0.0.0.0:8000      listen on every address, so other containers can
#                            reach it, not just this one
#   --workers 2              run two copies, so one slow call doesn't block the rest
#   --access-logfile -       print a line for every call, for docker compose logs
#   --no-control-socket      gunicorn's control socket lives in the home folder,
#                            which nobody can't write to; the app doesn't use it
#   app:app                  the app is the variable app, in app.py
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", "--access-logfile", "-", "--no-control-socket", "app:app"]
