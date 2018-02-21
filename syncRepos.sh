#!/bin/bash
for i in {1..4}
do

tput setaf 2
echo "klaster$i"
tput sgr0


ssh klaster$i "cd ~/cluster-management-scripts && git pull origin master"
done

