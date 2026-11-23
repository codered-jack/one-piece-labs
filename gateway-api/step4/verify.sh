#!/bin/bash
# Passes when ~/poster.txt holds the wanted poster's text.
grep -q "WANTED: Monkey D. Luffy" /root/poster.txt 2>/dev/null
