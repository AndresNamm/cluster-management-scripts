#!/bin/bash 
machines=$1
keywords=$2
for machine in $(cat $machines)
do
echo "GOING THROUGH MACHINE $machine"
for keyword in $(cat $keywords)
do
echo "SEARCHING FOR KEYWORD $keyword"
ssh -t root@$machine "find / -name $keyword"
done
done



















