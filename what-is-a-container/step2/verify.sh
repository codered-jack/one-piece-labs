#!/bin/bash
# Passes when ~/container-os.txt holds Alpine's os-release, which only a
# container can print on this Ubuntu machine.
grep -qx 'ID=alpine' /root/container-os.txt 2>/dev/null
