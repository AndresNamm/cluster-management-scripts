#!/bin/bash 
group=$1 
processes=$2
for process in $(cat $processes)
do
echo $process
clush -g $group ps -u $process 
done













