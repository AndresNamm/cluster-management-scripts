#!/bin/bash 
group=$1 
logDirs=$2
for logDir in $(cat $logDirs)
do
echo "CHECKING EXISTANCE OF DIRECTORY $logDir"
clush -l root -g $group ls -la $logDir
done













