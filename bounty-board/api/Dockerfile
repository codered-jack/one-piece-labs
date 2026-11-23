FROM python:3.12-alpine
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY app.py bounties.py ./
USER nobody
EXPOSE 8000
# gunicorn's control socket lives in the home folder, which nobody can't write
# to; the app doesn't use it, so it's switched off.
CMD ["gunicorn", "--bind", "0.0.0.0:8000", "--workers", "2", "--access-logfile", "-", "--no-control-socket", "app:app"]
