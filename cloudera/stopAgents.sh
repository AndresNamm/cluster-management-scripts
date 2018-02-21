#!/bin/bash
for i in {1..4}
do 
ssh -t root@klaster$i "sudo service cloudera-scm-agent stop"
done
