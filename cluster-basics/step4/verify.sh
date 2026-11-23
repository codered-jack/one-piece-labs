#!/bin/bash
# Passes when ~/hideout.txt names the namespace the setup script hid the
# stowaway pod in.
[ "$(tr -d '[:space:]' < /root/hideout.txt 2>/dev/null)" = "cargo-hold" ]
