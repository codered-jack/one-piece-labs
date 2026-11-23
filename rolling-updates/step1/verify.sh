#!/bin/bash
# Passes when ~/version.txt holds the Python 3.12 version line the
# Den Den Mushi prints, like "Python 3.12.16".
grep -Eq '^Python 3\.12\.[0-9]+' /root/version.txt 2>/dev/null
