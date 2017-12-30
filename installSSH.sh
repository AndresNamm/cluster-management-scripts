#!/bin/bash 
for i in {1..3}
do 
ssh -t root@klaster$i "apt-get install -y openssh-client"
done
