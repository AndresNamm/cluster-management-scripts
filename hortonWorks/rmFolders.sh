#!/bin/bash 
group=$1 
logDirs=$2
for logDir in $(cat $logDirs)
do
echo $logDir 
clush -l root -g $group rm -rf $logDir
done













