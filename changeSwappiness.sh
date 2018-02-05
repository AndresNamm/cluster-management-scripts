#!/bin/bash 
#https://askubuntu.com/questions/103915/how-do-i-configure-swappiness
for i in range {1..4}
do 
ssh -t root@klaster$i "sysctl vm.swappiness=10 && swapoff -a && swapon -a"
done 
