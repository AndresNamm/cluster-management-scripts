#!/bin/bash
for cluster_number in {1..4} 
do 
ssh -t klaster$cluster_number "journalctl -k | grep error; journalctl -k | grep -i \"stalls on CPUs/tasks\""
done
