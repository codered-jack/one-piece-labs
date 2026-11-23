#!/bin/bash
# End-to-end test for the Bounty Board. Run it from the bounty-board folder:
#   bash tests/smoke-test.sh
# It builds and starts the app with Docker Compose, drives it through
# http://localhost:9000 the way a browser would, stops parts of it on purpose,
# and finishes with `docker compose down -v`, which DELETES the app's data.
# It needs curl, to call the app, and python3, to read its JSON answers.
set -u

for tool in curl python3; do
  command -v "$tool" >/dev/null || { echo "FAIL  this test needs $tool"; exit 1; }
done

BASE=http://localhost:9000
failures=0

pass() { echo "PASS  $1"; }
fail() { echo "FAIL  $1"; failures=$((failures + 1)); }

# expect <description> <expected> <actual>
expect() { if [ "$2" = "$3" ]; then pass "$1"; else fail "$1 (expected '$2', got '$3')"; fi; }

status_of() { curl -s -o /dev/null -w '%{http_code}' "$@"; }
source_of() { python3 -c 'import json, sys; print(json.load(sys.stdin)["source"])'; }
count_of() { python3 -c 'import json, sys; print(len(json.load(sys.stdin)["bounties"]))'; }
first_name_of() { python3 -c 'import json, sys; print(json.load(sys.stdin)["bounties"][0]["name"])'; }
post() { curl -s -o /dev/null -w '%{http_code}' -X POST -H 'Content-Type: application/json' --data "$1" "$BASE/api/bounties"; }

wait_for_app() {
  for _ in $(seq 1 60); do
    [ "$(status_of "$BASE/api/health")" = "200" ] && return 0
    sleep 1
  done
  return 1
}

docker compose down -v >/dev/null 2>&1
docker compose up -d --build --quiet-pull >/dev/null 2>&1 || { echo "FAIL  docker compose up"; exit 1; }
wait_for_app || { echo "FAIL  the app never became healthy"; docker compose ps; exit 1; }

echo "--- reads"
expect "health reports both parts up" '{"cache":"up","database":"up"}' "$(curl -s "$BASE/api/health" | tr -d ' \n')"
first=$(curl -s "$BASE/api/bounties")
expect "first read comes from the database" "database" "$(source_of <<< "$first")"
expect "the seed data has 5 bounties" "5" "$(count_of <<< "$first")"
expect "highest bounty first" "Monkey D. Luffy" "$(first_name_of <<< "$first")"
expect "second read comes from the cache" "cache" "$(curl -s "$BASE/api/bounties" | source_of)"
expect "the web page is served" "200" "$(status_of "$BASE/")"

echo "--- writes"
expect "a valid bounty is created" "201" "$(post '{"name": "Nico Robin", "bounty": 930000000}')"
after=$(curl -s "$BASE/api/bounties")
expect "adding a bounty clears the cache" "database" "$(source_of <<< "$after")"
expect "the new bounty is listed" "6" "$(count_of <<< "$after")"

echo "--- bad input"
expect "an empty name is refused" "400" "$(post '{"name": "  ", "bounty": 1}')"
expect "a 41-character name is refused" "400" "$(post "{\"name\": \"$(printf 'a%.0s' $(seq 1 41))\", \"bounty\": 1}")"
expect "a negative bounty is refused" "400" "$(post '{"name": "Buggy", "bounty": -1}')"
expect "a bounty as text is refused" "400" "$(post '{"name": "Buggy", "bounty": "lots"}')"
expect "a bounty of true is refused" "400" "$(post '{"name": "Buggy", "bounty": true}')"
expect "a fractional bounty is refused" "400" "$(post '{"name": "Buggy", "bounty": 1.5}')"
expect "a bounty over the limit is refused" "400" "$(post '{"name": "Buggy", "bounty": 100000000000}')"
expect "malformed JSON is refused" "400" "$(post '{"name": ')"
expect "a JSON list is refused" "400" "$(post '[1, 2]')"
expect "a body over 1 KB is refused" "413" "$(post "{\"name\": \"$(head -c 2000 /dev/zero | tr '\0' 'a')\", \"bounty\": 1}")"
expect "an unknown path answers 404" "404" "$(status_of "$BASE/api/nowhere")"
expect "nothing invalid was stored" "6" "$(curl -s "$BASE/api/bounties" | count_of)"

echo "--- persistence"
docker compose down >/dev/null 2>&1
docker compose up -d >/dev/null 2>&1
wait_for_app || fail "the app came back after down and up"
expect "bounties survive down and up" "6" "$(curl -s "$BASE/api/bounties" | count_of)"

echo "--- the cache is down"
docker compose stop cache >/dev/null 2>&1
expect "reads still work, from the database" "database" "$(curl -s "$BASE/api/bounties" | source_of)"
expect "health reports the cache down" "503" "$(status_of "$BASE/api/health")"
docker compose start cache >/dev/null 2>&1

echo "--- the database is down"
docker compose stop db >/dev/null 2>&1
expect "health reports the database down" "503" "$(status_of "$BASE/api/health")"
expect "adding a bounty answers 503" "503" "$(post '{"name": "Brook", "bounty": 383000000}')"
docker compose start db >/dev/null 2>&1
wait_for_app || fail "the app recovered after the database came back"
expect "the app recovers when the database is back" "200" "$(status_of "$BASE/api/bounties")"

echo "--- down -v deletes the data"
docker compose down -v >/dev/null 2>&1
docker compose up -d >/dev/null 2>&1
wait_for_app || fail "the app came back after down -v"
expect "after down -v, only the 5 seed bounties remain" "5" "$(curl -s "$BASE/api/bounties" | count_of)"
docker compose down -v >/dev/null 2>&1

echo
if [ "$failures" -eq 0 ]; then echo "All checks passed."; else echo "$failures check(s) failed."; exit 1; fi
