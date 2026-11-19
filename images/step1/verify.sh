#!/bin/bash
# Passes when alpine:3.20 is on the machine.
docker image inspect alpine:3.20 >/dev/null 2>&1
