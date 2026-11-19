#!/bin/bash
echo "Running cluster checks, two to four minutes..."
while [ ! -f /root/spike/done ]; do sleep 2; done
clear
cat /root/spike/report.txt
