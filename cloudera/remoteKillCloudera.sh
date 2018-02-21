#!/bin/bash
for i in {1..4}
do 
tput setaf 2
echo "klaster$i"
tput sgr0
ssh -t root@klaster$i "bash /home/andres/cluster-management-scripts/cloudera/killCloudera.sh"
done
