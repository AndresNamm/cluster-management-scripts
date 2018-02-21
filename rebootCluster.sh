#!/bin/bash 
for i in {2,4}
do 
ssh -t root@klaster$i "reboot"
done
