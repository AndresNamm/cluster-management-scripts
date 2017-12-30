#!/bin/bash 
for i in {1..3}
do 
ssh -t root@klaster$i "apt-get -y update &&apt-get -y dist-upgrade"
done
