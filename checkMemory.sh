#!/bin/bash
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`
for cluster_number in {1..4} 
do 
echo ""
echo ""
tput setaf 2
echo "KLASTER$cluster_number"
tput sgr0

ssh -t klaster$cluster_number "echo \"${red}memory available${reset}\";free; echo \"${red}kernel version${reset}\";uname -r"
echo
done




