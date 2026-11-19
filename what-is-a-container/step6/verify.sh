#!/bin/bash
# Passes when no container named napper exists, running or stopped.
! docker container inspect napper >/dev/null 2>&1
