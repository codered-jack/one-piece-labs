"""HTTP routes for the Bounty Board API. Storage lives in bounties.py."""

from dataclasses import dataclass

import psycopg
from flask import Flask, jsonify, request
from werkzeug.exceptions import HTTPException

import bounties

MAX_NAME_LENGTH = 40
MAX_BOUNTY = 99_999_999_999
MAX_REQUEST_BYTES = 1024

app = Flask(__name__)
app.config["MAX_CONTENT_LENGTH"] = MAX_REQUEST_BYTES


@dataclass(frozen=True)
class NewBounty:
    name: str
    bounty: int


class InvalidBounty(ValueError):
    """The request body isn't a valid new bounty; the message says why."""


def parse_new_bounty(payload: object) -> NewBounty:
    if not isinstance(payload, dict):
        raise InvalidBounty("send a JSON object with name and bounty")
    name = payload.get("name")
    amount = payload.get("bounty")
    if not isinstance(name, str) or not 1 <= len(name.strip()) <= MAX_NAME_LENGTH:
        raise InvalidBounty(f"name must be text, 1 to {MAX_NAME_LENGTH} characters")
    # bool is a subclass of int in Python, so true/false must be ruled out by name.
    if isinstance(amount, bool) or not isinstance(amount, int) or not 0 <= amount <= MAX_BOUNTY:
        raise InvalidBounty(f"bounty must be a whole number from 0 to {MAX_BOUNTY}")
    return NewBounty(name=name.strip(), bounty=amount)


@app.get("/api/bounties")
def get_bounties():
    items, source = bounties.list_bounties()
    return jsonify(source=source, bounties=items)


@app.post("/api/bounties")
def post_bounty():
    payload = request.get_json(silent=True)
    try:
        new = parse_new_bounty(payload)
    except InvalidBounty as error:
        return jsonify(error=str(error)), 400
    return jsonify(bounties.add_bounty(new.name, new.bounty)), 201


@app.get("/api/health")
def health():
    status = {
        "database": "up" if bounties.database_is_up() else "down",
        "cache": "up" if bounties.cache_is_up() else "down",
    }
    healthy = all(value == "up" for value in status.values())
    return jsonify(status), 200 if healthy else 503


@app.errorhandler(psycopg.OperationalError)
def database_unavailable(_error: psycopg.OperationalError):
    return jsonify(error="the database is unavailable"), 503


@app.errorhandler(HTTPException)
def http_error(error: HTTPException):
    return jsonify(error=error.description), error.code
