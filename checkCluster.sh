#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
for cluster_number in {1..4} 
do 
echo ""
echo ""
tput setaf 2
echo "KLASTER$i"
tput sgr0

ssh -t klaster$cluster_number "echo \"${red}general errors${reset}\";journalctl -k | grep error; echo \"${red}stalls${reset}\";journalctl -k | grep -i \"stalls on CPUs/tasks\""
echo
done
