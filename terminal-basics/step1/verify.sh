#!/bin/bash
# Passes when something answers HTTP on port 8080.
curl -fs -o /dev/null --max-time 3 http://localhost:8080
