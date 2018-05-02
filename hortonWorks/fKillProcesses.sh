#!/bin/bash 
processes=$2
machines=$1
for machine in $(cat $machines)
do 
echo "$machine"
for process in $(cat $processes)
do
echo "$machine $process" 
ssh -t root@$machine "ps -u $process -o pid= | xargs kill -9"
done
done













