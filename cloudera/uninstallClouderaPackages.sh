#!/bin/bash

for i in {1..4}
do 
tput setaf 2
echo "klaster$i"
tput sgr0
ssh -t root@klaster$i "sudo apt-get purge 'cloudera-manager-*' && apt-get clean"
done
