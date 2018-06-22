#!/bin/bash 
red=`tput setaf 1`
green=`tput setaf 2`
reset=`tput sgr0`

for user in $(cut -f1 -d: /etc/passwd)
do
kar=$(crontab -u $user -l 2>/dev/null) 
if [[ -n "$kar" ]]
then
echo "${red}+ $user${reset}"
crontab -u $user -l
fi
done


