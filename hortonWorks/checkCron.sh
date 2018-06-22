#!/bin/bash 
machines=$1
for machine in $(cat $machines)
do 
echo "MACHINEEEEEE NAMED: $machine"
for user in $(ssh -t $machine 'cut -f1 -d: /etc/passwd')
do
echo $user 
ssh -t $machine 'crontab -u $user -l'
done
done













