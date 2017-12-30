#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
for cluster_number in {1..3} 
do 
echo ""
echo ""
tput setaf 2
echo "KLASTER$cluster_number"
tput sgr0

ssh -t klaster$cluster_number "echo \"${red}general errors${reset}\";journalctl -b | grep error; echo \"${red}stalls${reset}\";journalctl -b | grep -i \"stalls on CPUs/tasks\""
echo
done
