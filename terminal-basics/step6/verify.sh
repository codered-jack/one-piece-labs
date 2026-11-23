#!/bin/bash
# Passes when nothing listens on any port this lab used.
! ss -ltnH '( sport = :8080 or sport = :9090 or sport = :7070 )' | grep -q .
