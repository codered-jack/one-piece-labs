"""Bounty storage. Postgres holds every bounty; Redis keeps a copy of the list
for CACHE_SECONDS, so most reads never reach the database (cache-aside)."""

import json
import logging
import os
from typing import Literal, TypedDict

import psycopg
import redis

# The cached list is stored in Redis under this name, for 30 seconds.
CACHE_KEY = "bounties"
CACHE_SECONDS = 30
# Give up on the database or the cache after 3 seconds, rather than hang.
CONNECT_TIMEOUT_SECONDS = 3

# Read at import, so a container started without its settings fails at boot
# with a KeyError naming the missing variable, not on the first request.
DATABASE_URL = os.environ["DATABASE_URL"]
REDIS_HOST = os.environ["REDIS_HOST"]

log = logging.getLogger(__name__)

# The connection to Redis. REDIS_HOST is the service name, cache; 6379 is
# Redis's port.
_cache = redis.Redis(
    host=REDIS_HOST,
    port=6379,
    socket_connect_timeout=CONNECT_TIMEOUT_SECONDS,
    socket_timeout=CONNECT_TIMEOUT_SECONDS,
    decode_responses=True,
)


class Bounty(TypedDict):
    id: int
    name: str
    bounty: int


Source = Literal["cache", "database"]


# --- Reading and adding bounties -------------------------------------------
# A read asks the cache first, and the database only when the cache has no
# copy. Adding a bounty drops the copy, so the next read is fresh.

def list_bounties() -> tuple[list[Bounty], Source]:
    """All bounties, highest first, and where they came from.

    Raises psycopg.OperationalError when the list isn't cached and the
    database can't be reached.
    """
    cached = _read_cache()
    if cached is not None:
        return cached, "cache"
    bounties = _read_database()
    _write_cache(bounties)
    return bounties, "database"


def add_bounty(name: str, bounty: int) -> Bounty:
    """Stores a new bounty and drops the cached list, so the next read sees it.

    Raises psycopg.OperationalError when the database can't be reached.
    """
    with _connect() as conn:
        row = conn.execute(
            "INSERT INTO bounties (name, bounty) VALUES (%s, %s) RETURNING id, name, bounty",
            (name, bounty),
        ).fetchone()
    _forget_cache()
    return {"id": row[0], "name": row[1], "bounty": row[2]}


# --- Health checks, for GET /api/health ------------------------------------

def database_is_up() -> bool:
    try:
        with _connect() as conn:
            conn.execute("SELECT 1")
        return True
    except psycopg.OperationalError:
        return False


def cache_is_up() -> bool:
    try:
        return bool(_cache.ping())
    except redis.RedisError:
        return False


# --- Talking to the database -----------------------------------------------

def _connect() -> psycopg.Connection:
    return psycopg.connect(DATABASE_URL, connect_timeout=CONNECT_TIMEOUT_SECONDS)


def _read_database() -> list[Bounty]:
    with _connect() as conn:
        rows = conn.execute("SELECT id, name, bounty FROM bounties ORDER BY bounty DESC, id").fetchall()
    return [{"id": r[0], "name": r[1], "bounty": r[2]} for r in rows]


# --- Talking to the cache --------------------------------------------------
# The cache only saves work, so every cache failure below is logged and
# skipped (fail-open): with Redis down, reads go to the database. The cost is
# in _forget_cache: if Redis is unreachable then, readers can see a list that
# is up to CACHE_SECONDS old.


def _read_cache() -> list[Bounty] | None:
    try:
        cached = _cache.get(CACHE_KEY)
    except redis.RedisError as error:
        log.warning("cache read failed, using the database: %s", error)
        return None
    return json.loads(cached) if cached is not None else None


def _write_cache(bounties: list[Bounty]) -> None:
    try:
        _cache.set(CACHE_KEY, json.dumps(bounties), ex=CACHE_SECONDS)
    except redis.RedisError as error:
        log.warning("cache write failed: %s", error)


def _forget_cache() -> None:
    try:
        _cache.delete(CACHE_KEY)
    except redis.RedisError as error:
        log.warning("cache delete failed, the list may be stale for up to %ss: %s", CACHE_SECONDS, error)
