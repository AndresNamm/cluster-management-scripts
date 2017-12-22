#!/bin/bash
for cluster_number in {1..4} 
do 
ssh -t klaster$cluster_number "echo "general errors";journalctl -k | grep error; echo "stalls";journalctl -k | grep -i \"stalls on CPUs/tasks\""
done
