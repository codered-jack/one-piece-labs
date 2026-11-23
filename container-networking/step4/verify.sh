#!/bin/bash
# Passes when den-den answers on localhost:9000 from the machine, and still
# answers by name on fleet, port 8000.
line="Purupurupuru! Den Den Mushi here."
[ "$(curl -s --max-time 5 localhost:9000)" = "$line" ] || exit 1
[ "$(docker run --rm --network fleet alpine wget -qO- -T 5 http://den-den:8000 2>/dev/null)" = "$line" ]
