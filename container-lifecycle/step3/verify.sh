#!/bin/bash
# Passes when /note.txt inside the running lookout contains exactly "ahoy".
[ "$(docker exec lookout cat /note.txt 2>/dev/null)" = "ahoy" ]
