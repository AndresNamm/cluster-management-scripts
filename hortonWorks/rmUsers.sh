#!/bin/bash 
group=$1 
users=$2
for user in $(cat $users)
do
echo "REMOVING $user" 
clush -l root -g $group userdel -r $user
done













