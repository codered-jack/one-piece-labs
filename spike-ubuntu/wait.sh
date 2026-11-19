#!/bin/bash
echo "Running environment checks, about a minute..."
while [ ! -f /root/spike/done ]; do sleep 2; done
clear
cat /root/spike/report.txt
